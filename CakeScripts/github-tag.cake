#addin nuget:?package=Cake.FileHelpers
#addin nuget:?package=Cake.Git
#addin nuget:?package=Cake.Incubator
#tool "nuget:?package=gitreleasemanager"

using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Xml.Linq;
using System.Xml.XPath;

// Task TARGET for build
var TARGET = Argument("target", Argument("t", "Default"));

Task("Default").IsDependentOn("GitRelease");

void HandleError(Exception exception)
{
    Information("An error occured");
    Error(exception.Message);
}

// Create a tag and release on GitHub
Task("GitRelease").Does(() =>
{
    // Use the package version for the NuGet as the release version
    var nuspecPathPrefix = EnvironmentVariable("NUSPEC_PATH", "nuget");
    var nuspecPath = System.IO.Path.Combine(nuspecPathPrefix, "*.nuspec");
    var nuspecXml = XDocument.Load(nuspecPath);
    var publishVersion = nuspecXml.XPathSelectElement("/package/metadata/version").Value;

    // Create temporary release notes.
    var releaseNotesFileName = "tmp-release-notes.md";
    System.IO.File.Create(releaseNotesFileName).Dispose();
    var releaseFile = File(releaseNotesFileName);

    FileWriteText(releaseFile, "Generated as a default value from scripts.\nPlease update release notes next time.");

    var username = "user";
    var password = Argument<string>("GithubToken");
    var owner = "repo-owner";
    var repo = "repo-name";
    var gitSettings =  new GitReleaseManagerCreateSettings {
                                Prerelease        = true,
                                TargetCommitish   = "master",
                                InputFilePath = releaseFile.Path.FullPath,
                                Name = publishVersion
                            });

    GitReleaseManagerCreate(username, password, owner, repo, gitSettings);
    GitReleaseManagerPublish(username, password, owner, repo, publishVersion);
    DeleteFile(releaseFile);

}).OnError(HandleError);

RunTarget(TARGET);
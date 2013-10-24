# TortoiseGit 

function private:Get-TortoiseGitPath {
  if ((Test-Path "C:\Program Files\TortoiseGit\bin\TortoiseGitProc.exe") -eq $true) {
    # TortoiseGit 1.8.0 renamed TortoiseProc to TortoiseGitProc.
    return "C:\Program Files\TortoiseGit\bin\TortoiseGitProc.exe"
  }

  return "C:\Program Files\TortoiseGit\bin\TortoiseProc.exe"
}

$Global:TortoiseGitSettings = new-object PSObject -Property @{
  TortoiseGitPath = (Get-TortoiseGitPath)
  TortoiseGitCommands = @{
    "about" = "about";
    "add" = "add";
    "blame" = "blame";
    "cat" = "cat";
    "cleanup" = "cleanup";
    "clean" = "cleanup";
    "commit" = "commit";
    "conflicteditor" = "conflicteditor";
    "createpatch" = "createpatch";
    "patch" = "createpatch";
    "diff" = "diff";
    "export" = "export";
    "help" = "help";
    "ignore" = "ignore";
    "log" = "log";
    "merge" = "merge";
    "pull" = "pull";
    "push" = "push";
    "rebase" = "rebase";
    "refbrowse" = "refbrowse";
    "reflog" = "reflog";
    "stash" = "stash";
    "remove" = "remove";
    "rm" = "remove";
    "rename" = "rename";
    "mv" = "rename";
    "repocreate" = "repocreate";
    "init" = "repocreate";
    "repostatus" = "repostatus";
    "status" = "repostatus";
    "resolve" = "resolve";
    "revert" = "revert";
    "settings" = "settings";
    "stashapply" = "stashapply";
    "stashsave" = "stashsave";
    "subadd" = "subadd";
    "subsync" = "subsync";
    "subupdate" = "subupdate";
    "switch" = "switch";
    "checkout" = "switch";
    "sync" = "sync";
  }
}

function tgit {
   if($args) {
    # Replace any aliases with actual TortoiseGit commands
    if ($Global:TortoiseGitSettings.TortoiseGitCommands.ContainsKey($args[0])) {
      $args[0] = $Global:TortoiseGitSettings.TortoiseGitCommands.Get_Item($args[0])
    }
    
    if($args[0] -eq "help") {
      # Replace the built-in help behaviour with just a list of commands
      $Global:TortoiseGitSettings.TortoiseGitCommands.Values.GetEnumerator() | sort | gu
      return    
    }

    $newArgs = @()

    $cmd = $args[0]
    if ($cmd -eq "stash") {
        $newArgs += "/command:reflog"
        $newArgs += "/ref:refs/stash"
    }
    else {
        $newArgs += "/command:" + $cmd
    }
    
    if($args.length -gt 1) {
      $args[1..$args.length] | % { $newArgs += $_ }
    }
      
    & $Global:TortoiseGitSettings.TortoiseGitPath $newArgs
  }
}

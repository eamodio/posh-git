# TortoiseGit 

$Global:TortoiseGitSettings = new-object PSObject -Property @{
  TortoiseGitPath = "C:\Program Files\TortoiseGit\bin\TortoiseGitProc.exe"
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
    $newArgs += "/command:" + $args[0]
    
    $cmd = $args[0]
    
    if($args.length -gt 1) {
      $args[1..$args.length] | % { $newArgs += $_ }
    }
      
    & $Global:TortoiseGitSettings.TortoiseGitPath $newArgs
  }
}

**git bisect** - find the "commit" culprit
---

Execute the following input file at [git-bisect-input-setup.sh](git-bisect-input-setup.sh)

```bash
cd git-bisect
sh git-bisect-input-setup.sh
```

> This generates some commits in the git history out of which we'll extract the "culprit" that produces "Auto" instead of "Boot" 

## Start **bisect** process
```
git bisect start
```
 
 
## FIND first good commit
### Show last commits 
```
git log --oneline
```
 
### Verify commit is by checking "Boot" is present in text
```
git checkout HASH_ID_WHERE_BOOT_IS_IN_TEXT # in real life you need to select one commit you know is good
```
 
### Mark commit as good
```
git bisect good HASH_ID_WHERE_BOOT_IS_IN_TEXT # the commit id from above
```
 
## FIND first bad commit 
### The latest (HEAD) has ist for sure - show HEAD hash
```
git rev-parse HEAD
``` 
 
### Mark commit as **bad** in the process
```
git bisect bad HEAD #or hash from previous command
```
 
### Verify the “status” again and mark the commit correspondingly 
```
less file.txt  #verify it has Boot instead of Auto
```
 
### Mark commit as good
```
git bisect good
```
 
## now verify status again - IT IS BAD
### Mark as bad
```
git bisect bad
```
 
### It should display the “faulty” commit and now you can end the **bisect** process
```
git bisect reset
```
 
### Confirm this is the FAULTY COMMIT
```
git checkout COMMIT_ID_FROM_ABOVE
git diff HEAD^ HEAD # ve
git checkout master #go to master
```
 
## GIT REVERT - fixing the commit
### Another way to retrieve the commit (“git search example”) 
```
git log --grep=’Auto’ --since=’1 hour ago’`
```
 
### Revert it 
```
git revert BAD_COMMIT_ID #it reverts automatically
git push
```  
 
> From time to time have a look in the git log graph to see how it looks like
 
## Revert with *no commit* option
### Reset to previous commit with the following command  
```
git reset --hard HEAD^
```
 
## Need to “force” push now, as history has been rewritten 
```
git push --force-with-lease
```

> Always prefer the [`--force-with-lease` option](https://stackoverflow.com/questions/52823692/git-push-force-with-lease-vs-force) 
> as is a safer option that will not overwrite any work on the remote branch if more commits were added to the remote branch.
> Otherwise bad things might happen

![git push -f](docs/img/git-push-f.gif)
 
### git revert with --no-commit
```
git revert BAD_COMMIT_ID --no-commit
```
 
## `git reset`  -- add new commit and correct error with different options
### Run resources git-bisect-input-reset-optional.sh
```
sh git-bisect-input-reset-optional-setup.sh
```

### verify git status - ahead of branch
```
git status
```
 
### Already staged afer commit - verify differences
```
git diff --staged origin/master
```
 
### Reset Change
```
git reset --mixed HEAD^   
```
 
> See [What's the difference between git reset --mixed, --soft, and --hard?](https://stackoverflow.com/questions/3528245/whats-the-difference-between-git-reset-mixed-soft-and-hard)
> to better understand the options when resetting...

### correct and commit file
 
**THAT’s IT**


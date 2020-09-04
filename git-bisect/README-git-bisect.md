Git Advanced Commands - `git bisect`
----
Example repository supporting the video:

TODO picture with link to youtube

> Corresponding blog post - [Git Advanced Commands - git bisect](https://www.codepedia.org/ama/git-advanced-commands-git-bisect)

## **git bisect** - find the (commit) culprit 
Follow the steps in the **[git-bisect-demo commands](git-bisect-demo.md)** file

> Some other git commands (like `git revert`, `git reset`, `git push --force-with-lease` etc.) 
> are presented in the demo and instructions


# Demo **git bisect** - find the "commit" culprit

## Setup
Execute the following input file at [git-bisect-input-setup.sh](git-bisect-input-setup.sh)

```
cd git-bisect

#linux
./git-bisect-input-setup.sh

#git-bash windows
sh git-bisect-input-setup.sh
```

or execute the commands manually to set up the basis scenario
```
echo Twinkle > git-bisect-example.txt
git add -A && git commit -m "add the word 'Twinkle'"
echo twinkle >> git-bisect-example.txt
git add -A && git commit -m "add second 'twinkle'"
echo little >> git-bisect-example.txt
git add -A && git commit -m "add third 'little'"
echo star >> git-bisect-example.txt
git add -A && git commit -m "add the word 'star'"
echo How >> git-bisect-example.txt
git add -A && git commit -m "add the word 'How'"
echo "I wonder" >> git-bisect-example.txt
git add -A && git commit -m "add the words 'I wonder'"
sed -i -e 's/star/moon/g' git-bisect-example.txt
git add -A && git commit -m "change the word 'star' to 'moon'"
echo "what you are"  >> git-bisect-example.txt
git add -A && git commit -m "add the word 'what you are'"
```

> This generates the [git-bisect-example.txt](git-bisect-example.txt) file which contains part of the famous song 
> "Twinkle, twinkle, little star" 
> ** An error has creeped in, and we want to find out what was the commit that caused with the help of `git bisect`**

## Start **bisect** process
```
git bisect start
```
 
## FIND first good commit
### Show last commits 
```
git log --oneline
```

### Verify the commit is by checking "star" is present in the [git-bisect-example.txt](git-bisect-example.txt) file
> Commit with title "add the word 'star'" sound right, let's verify that one
```
git checkout HASH_ID_WHERE_START_IS_IN_TEXT # in real life you need to select one commit you know is good
```
 
### Mark commit as good in `git bisect` process
```
git bisect good HASH_ID_WHERE_START_IS_IN_TEXT # the commit id from above
```
 
## FIND first bad commit 
### The latest commit (HEAD) has ist for sure - show HEAD hash
```
git rev-parse HEAD
``` 
 
### Mark commit as **bad** in the `git bisect` process
```
git bisect bad HEAD #or hash from previous command
```
 
### Verify the “status” again and mark the commit correspondingly 
```
less git-bisect-example.txt  #verify it contains "moon" instead of "star"
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
git checkout COMMIT_ID_FOUND_VIA_GIT_BISECT
git diff HEAD^ HEAD # this compares the HEAD with the commit before it
git switch master # checkout master again
```
 
## GIT REVERT - fixing the commit
### Another way to retrieve the "faulty" commit (“git search example”) 
```
git log --grep=’moon’ --since=’1 hour ago’`
```
 
### Revert it 
```
git revert COMMIT_ID_FOUND_VIA_GIT_BISECT #it reverts automatically
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
 
### `git revert` with `--no-commit`
```
git revert COMMIT_ID_FOUND_VIA_GIT_BISECT --no-commit
```



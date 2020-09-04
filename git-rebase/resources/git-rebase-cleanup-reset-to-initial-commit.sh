# delete "feat-1" branch
git branch -D feat-1 #local
git push --delete origin feat-1 #remote

# delete "feat-2" branch
git branch -D feat-2 #local
git push --delete origin feat-2 #remote

INITIAL_COMMIT=$(git log --oneline --grep="initial commit" --pretty=format:"%h")

git reset --hard ${INITIAL_COMMIT}

git push --force-with-lease
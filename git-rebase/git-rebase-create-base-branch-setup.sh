# delete other branches than "master"
git checkout master

git branch -D feat-1
git push --delete origin feat-1

git branch -D feat-2
git push --delete origin feat-2

git checkout -b feat-1
echo "An applle a day" > file-one.md
git add file-one.md
git commit -m "keeps the doctor away

feat-1"
git push -u origin HEAD

git checkout master

git checkout -b feat-2
echo "Actions speak louder" > file-two.md
git add file-two.md
git commit -m "than words

feat-2"
git push -u origin HEAD

git checkout feat-1
echo "keeps the doctor away" >> file-one.md
git add file-one.md
git commit -m "An apple a day

feat-1"
git push

git checkout feat-2
echo "than words" >> file-two.md
git add file-two.md
git commit -m "Actions speak louder

feat-2"
git push


git checkout master


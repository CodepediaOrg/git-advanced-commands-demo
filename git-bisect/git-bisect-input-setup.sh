#git bisect
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
sed -i '' 's/star/moon/g' git-bisect-example.txt
git add -A && git commit -m "change the word 'star' to 'moon'"
echo "what you are"  >> git-bisect-example.txt
git add -A && git commit -m "add the word 'what you are'"


# Twinkle, twinkle, little star
# How I wonder what you are

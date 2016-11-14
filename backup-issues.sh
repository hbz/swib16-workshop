curl 'https://api.github.com/repos/hbz/swib16-workshop/issues?state=all' | jq -c '.[] | {id: .number, body: .body, comments: .comments_url'} > issues.jsonl

while read ISSUE
do
	ID=$(echo $ISSUE | jq '.id')
	echo $ISSUE | jq '.body' > $ID.txt
	URL=$(echo $ISSUE | jq '.comments' | tr -d '"')
	curl $URL | jq '.[] | .body' >> $ID.txt
done < issues.jsonl

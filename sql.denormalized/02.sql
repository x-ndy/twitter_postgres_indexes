SELECT '#' || a.hashtag AS tag, count(*) AS count 
FROM (SELECT data->>'id', jsonb_path_query(data, '$.extended_tweet.entities.hashtags[*]')->>'text' AS hashtag
        FROM tweets_jsonb
    WHERE data->'extended_tweet'->'entities'->'hashtags'@@'$[*].text == "coronavirus"'
    UNION
    SELECT data->>'id', jsonb_path_query(data, '$.entities.hashtags[*]')->>'text' AS hashtag
        FROM tweets_jsonb
    WHERE data->'entities'->'hashtags'@@'$[*].text == "coronavirus"'
)a
GROUP BY a.hashtag
ORDER BY count DESC, a.hashtag
LIMIT 1000;

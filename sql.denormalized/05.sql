SELECT '#' || a.hashtag as tag, count(*) AS count 
FROM (
    SELECT DISTINCT data->>'id' AS id, jsonb_array_elements(data->'entities'->'hashtags' || COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]'))->>'text' AS hashtag
    FROM tweets_jsonb
    WHERE to_tsvector('english',COALESCE(data->'extended_tweet'->>'full_text',data->>'text')) @@ to_tsquery('english','coronavirus')
      AND data->>'lang'='en'
)a
GROUP BY a.hashtag
ORDER BY count desc, a.hashtag
LIMIT 1000;


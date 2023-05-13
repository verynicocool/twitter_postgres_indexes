SELECT '#' || t.hashtag AS tag, COUNT(*) AS count 
FROM ( SELECT DISTINCT data->>'id' AS id_tweets, jsonb_array_elements(data->'entities'->'hashtags' || COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]'))->>'text' AS hashtag
       FROM tweets_jsonb
       WHERE to_tsvector('english',COALESCE(data->'extended_tweet'->>'full_text',data->>'text')) @@ to_tsquery('english','coronavirus')
       AND data->>'lang'='en'
)t
GROUP BY 1
ORDER BY 2 desc, 1
LIMIT 1000;

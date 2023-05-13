SELECT '#' || t.hashtag AS tag, COUNT(*) as count
FROM ( SELECT DISTINCT
        data->>'id' AS id_tweets, jsonb_array_elements(data->'entities'->'hashtags')->>'text' AS hashtag
    FROM tweets_jsonb
    WHERE data->'entities'->'hashtags'@@'$[*].text == "coronavirus"'
    UNION
    SELECT DISTINCT data->>'id' AS id_tweets, jsonb_array_elements(data->'extended_tweet'->'entities'->'hashtags')->>'text' AS hashtag
    FROM tweets_jsonb
    WHERE data->'extended_tweet'->'entities'->'hashtags'@@'$[*].text == "coronavirus"')t
GROUP BY 1
ORDER BY 2 DESC, 1
LIMIT 1000;

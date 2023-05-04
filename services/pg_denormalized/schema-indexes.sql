CREATE INDEX ON tweets_jsonb using gin((data->'entities'->'hashtags'));

CREATE INDEX ON tweets_jsonb using gin((data->'extended_tweet'->'entities'->'hashtags'));

CREATE INDEX ON tweets_jsonb ((data->>'lang'));

CREATE INDEX ON tweets_jsonb using gin(to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text'))) where data->>'lang'='en';

CREATE INDEX ON tweets_jsonb USING gin(to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text')), (data->'entities'->'hashtags' || COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')));



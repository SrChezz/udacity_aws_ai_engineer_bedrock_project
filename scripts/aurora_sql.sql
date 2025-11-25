"CREATE EXTENSION IF NOT EXISTS vector;",
"CREATE SCHEMA IF NOT EXISTS bedrock_integration;",
"DO $$ BEGIN CREATE ROLE bedrock_user LOGIN; EXCEPTION WHEN duplicate_object THEN RAISE NOTICE 'Role already exists'; END $$;",
"GRANT ALL ON SCHEMA bedrock_integration to bedrock_user;",
"SET SESSION AUTHORIZATION bedrock_user;",
"""
CREATE TABLE IF NOT EXISTS bedrock_integration.bedrock_kb (
    id uuid PRIMARY KEY,
    embedding vector(1536),
    chunks text,
    metadata json
);
""",
"CREATE INDEX IF NOT EXISTS bedrock_kb_embedding_idx ON bedrock_integration.bedrock_kb USING hnsw (embedding vector_cosine_ops);"
-- Added becasuse of not found index error!
-- operation error Bedrock Agent: CreateKnowledgeBase, https response error StatusCode: 400,
-- │ RequestID: 65650aa7-d6e2-49ac-b8f6-8f931cd222d2, ValidationException: The knowledge base storage
-- │ configuration provided is invalid... chunks column must be indexed. The SQL command to index the
-- │ column is: CREATE INDEX ON <table_name> USING gin (to_tsvector('simple', <text_field>)) or
-- │ CREATE INDEX ON <table_name> USING gin (to_tsvector('english', <text_field>))

"CREATE INDEX IF NOT EXISTS bedrock_kb_chunks_fts_idx ON bedrock_integration.bedrock_kb USING gin (to_tsvector('english', chunks));"
CREATE SCHEMA IF NOT EXISTS api;

CREATE TABLE IF NOT EXISTS api.todos (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    is_complete BOOLEAN DEFAULT false,
    inserted_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE api.todos ENABLE ROW LEVEL SECURITY;

-- Create policies to ensure users can only access their own todos
CREATE POLICY "Users can view own todos" ON api.todos
FOR SELECT TO authenticated
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own todos" ON api.todos
FOR INSERT TO authenticated
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own todos" ON api.todos
FOR UPDATE TO authenticated
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own todos" ON api.todos
FOR DELETE TO authenticated
USING (auth.uid() = user_id);

-- Create an index for performance
CREATE INDEX idx_todos_user_id ON api.todos(user_id);
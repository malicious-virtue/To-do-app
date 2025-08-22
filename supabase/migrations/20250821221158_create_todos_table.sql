-- Create todos table
CREATE TABLE IF NOT EXISTS api.todos (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    description TEXT,
    status TEXT DEFAULT 'pending' 
        CHECK (status IN ('pending', 'in_progress', 'completed', 'blocked')),
    priority TEXT DEFAULT 'medium' 
        CHECK (priority IN ('low', 'medium', 'high', 'urgent')),
    due_date TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Enable Row Level Security
ALTER TABLE api.todos ENABLE ROW LEVEL SECURITY;

-- Indexes for performance
CREATE INDEX idx_todos_user_id ON api.todos(user_id);
CREATE INDEX idx_todos_status ON api.todos(status);
CREATE INDEX idx_todos_due_date ON api.todos(due_date);

-- RLS Policies
-- SELECT Policy: Users can only view their own todos
CREATE POLICY "Users can view their own todos" ON api.todos
    FOR SELECT 
    TO authenticated 
    USING ((SELECT auth.uid()) = user_id);

-- INSERT Policy: Users can create todos only for themselves
CREATE POLICY "Users can create their own todos" ON api.todos
    FOR INSERT 
    TO authenticated 
    WITH CHECK ((SELECT auth.uid()) = user_id);

-- UPDATE Policy: Users can update only their own todos
CREATE POLICY "Users can update their own todos" ON api.todos
    FOR UPDATE 
    TO authenticated 
    USING ((SELECT auth.uid()) = user_id)
    WITH CHECK ((SELECT auth.uid()) = user_id);

-- DELETE Policy: Users can delete only their own todos
CREATE POLICY "Users can delete their own todos" ON api.todos
    FOR DELETE 
    TO authenticated 
    USING ((SELECT auth.uid()) = user_id);

-- Optional: Admin override policy
CREATE POLICY "Admins can manage all todos" ON api.todos
    FOR ALL 
    TO authenticated 
    USING ((auth.jwt() ->> 'user_role') = 'admin')
    WITH CHECK ((auth.jwt() ->> 'user_role') = 'admin');
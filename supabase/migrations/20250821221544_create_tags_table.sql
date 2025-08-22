-- Create tags table
CREATE TABLE api.tags (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    name TEXT UNIQUE NOT NULL,
    color TEXT
);

-- Todo-Tags junction table
CREATE TABLE api.todo_tags (
    todo_id UUID REFERENCES api.todos(id) ON DELETE CASCADE,
    tag_id UUID REFERENCES api.tags(id) ON DELETE CASCADE,
    PRIMARY KEY (todo_id, tag_id)
);

-- Enable Row Level Security
ALTER TABLE api.tags ENABLE ROW LEVEL SECURITY;
ALTER TABLE api.todo_tags ENABLE ROW LEVEL SECURITY;

-- RLS Policy for Tags
CREATE POLICY "Users can view tags" ON api.tags FOR SELECT TO authenticated USING (true);

-- Sample tags
INSERT INTO api.tags (name, color) VALUES 
('Work', '#FF6B6B'),
('Personal', '#4ECDC4'),
('Urgent', '#FF6B6B'),
('Low Priority', '#A8DADC');
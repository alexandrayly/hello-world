-- Core tables for character ingestion and high-frequency short replies.

CREATE TABLE IF NOT EXISTS characters (
  id TEXT PRIMARY KEY,
  name_zh TEXT NOT NULL,
  codename_en TEXT NOT NULL UNIQUE,
  age INTEGER NOT NULL CHECK (age > 0),
  occupation TEXT NOT NULL,
  city TEXT NOT NULL,
  archetype TEXT NOT NULL,
  attachment_style TEXT NOT NULL,
  core_motivation TEXT NOT NULL,
  deep_fear TEXT NOT NULL,
  relationship_goal TEXT NOT NULL,
  speaking_style TEXT NOT NULL,
  likes TEXT NOT NULL,
  boundaries TEXT NOT NULL,
  secret_reveal TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS character_replies (
  id TEXT PRIMARY KEY,
  character_id TEXT NOT NULL REFERENCES characters(id) ON DELETE CASCADE,
  category TEXT NOT NULL CHECK (
    category IN (
      'greeting',
      'care',
      'jealousy',
      'apology',
      'daily',
      'goodnight'
    )
  ),
  tone TEXT NOT NULL,
  content TEXT NOT NULL,
  sort_order INTEGER NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_character_replies_character_category
  ON character_replies(character_id, category, sort_order);

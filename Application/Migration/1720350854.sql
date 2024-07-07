ALTER TABLE companies ADD COLUMN games_id UUID NOT NULL;
ALTER TABLE goods ADD COLUMN games_id UUID DEFAULT null;
ALTER TABLE routes ADD COLUMN games_id UUID DEFAULT uuid_generate_v4() NOT NULL;
ALTER TABLE locations DROP CONSTRAINT locations_ref_company_id;
CREATE TABLE games (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL
);
CREATE INDEX games_created_at_index ON games (created_at);
CREATE TRIGGER update_games_updated_at BEFORE UPDATE ON games FOR EACH ROW EXECUTE FUNCTION set_updated_at_to_now();
ALTER TABLE companies ADD CONSTRAINT companies_ref_games_id FOREIGN KEY (games_id) REFERENCES games (id) ON DELETE CASCADE;
ALTER TABLE goods ADD CONSTRAINT goods_ref_games_id FOREIGN KEY (games_id) REFERENCES games (id) ON DELETE NO ACTION;
ALTER TABLE locations ADD CONSTRAINT locations_ref_company_id FOREIGN KEY (company_id) REFERENCES companies (id) ON DELETE CASCADE;
ALTER TABLE routes ADD CONSTRAINT routes_ref_games_id FOREIGN KEY (games_id) REFERENCES games (id) ON DELETE NO ACTION;

ALTER TABLE companies RENAME COLUMN games_id TO game_id;
ALTER TABLE goods RENAME COLUMN games_id TO game_id;
ALTER TABLE routes RENAME COLUMN games_id TO game_id;
ALTER TABLE companies DROP CONSTRAINT companies_ref_games_id;
ALTER TABLE goods DROP CONSTRAINT goods_ref_games_id;
ALTER TABLE routes DROP CONSTRAINT routes_ref_games_id;
ALTER TABLE companies ADD CONSTRAINT companies_ref_game_id FOREIGN KEY (game_id) REFERENCES games (id) ON DELETE CASCADE;
ALTER TABLE goods ADD CONSTRAINT goods_ref_game_id FOREIGN KEY (game_id) REFERENCES games (id) ON DELETE NO ACTION;
ALTER TABLE routes ADD CONSTRAINT routes_ref_game_id FOREIGN KEY (game_id) REFERENCES games (id) ON DELETE NO ACTION;

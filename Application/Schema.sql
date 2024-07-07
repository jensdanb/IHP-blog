CREATE FUNCTION set_updated_at_to_now() RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language plpgsql;
-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE posts (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);
CREATE INDEX posts_created_at_index ON posts (created_at);
CREATE TABLE comments (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    post_id UUID NOT NULL,
    author TEXT NOT NULL,
    body TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);
CREATE INDEX comments_post_id_index ON comments (post_id);
CREATE INDEX comments_created_at_index ON comments (created_at);
CREATE TABLE stocks (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    good_id UUID NOT NULL,
    location_id UUID NOT NULL
);
CREATE TABLE companies (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    name TEXT NOT NULL,
    game_id UUID NOT NULL
);
CREATE TABLE locations (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    company_id UUID NOT NULL
);
CREATE TABLE routes (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    from_stock_id UUID NOT NULL,
    to_stock_id UUID NOT NULL UNIQUE,
    game_id UUID DEFAULT uuid_generate_v4() NOT NULL
);
CREATE INDEX companies_created_at_index ON companies (created_at);
CREATE TRIGGER update_companies_updated_at BEFORE UPDATE ON companies FOR EACH ROW EXECUTE FUNCTION set_updated_at_to_now();
CREATE INDEX locations_created_at_index ON locations (created_at);
CREATE TRIGGER update_locations_updated_at BEFORE UPDATE ON locations FOR EACH ROW EXECUTE FUNCTION set_updated_at_to_now();
CREATE INDEX locations_company_id_index ON locations (company_id);
CREATE TABLE goods (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    name TEXT NOT NULL,
    for_sale BOOLEAN DEFAULT false NOT NULL,
    cost INT DEFAULT 0 NOT NULL,
    price INT DEFAULT NULL,
    game_id UUID DEFAULT NULL
);
CREATE INDEX goods_created_at_index ON goods (created_at);
CREATE TRIGGER update_goods_updated_at BEFORE UPDATE ON goods FOR EACH ROW EXECUTE FUNCTION set_updated_at_to_now();
CREATE INDEX stocks_created_at_index ON stocks (created_at);
CREATE TRIGGER update_stocks_updated_at BEFORE UPDATE ON stocks FOR EACH ROW EXECUTE FUNCTION set_updated_at_to_now();
CREATE INDEX stocks_good_id_index ON stocks (good_id);
CREATE INDEX stocks_location_id_index ON stocks (location_id);
CREATE INDEX routes_created_at_index ON routes (created_at);
CREATE TABLE games (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    title TEXT NOT NULL UNIQUE,
    score INT DEFAULT 0 NOT NULL
);
CREATE INDEX games_created_at_index ON games (created_at);
CREATE TRIGGER update_games_updated_at BEFORE UPDATE ON games FOR EACH ROW EXECUTE FUNCTION set_updated_at_to_now();
ALTER TABLE comments ADD CONSTRAINT comments_ref_post_id FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE CASCADE;
ALTER TABLE companies ADD CONSTRAINT companies_ref_game_id FOREIGN KEY (game_id) REFERENCES games (id) ON DELETE CASCADE;
ALTER TABLE goods ADD CONSTRAINT goods_ref_game_id FOREIGN KEY (game_id) REFERENCES games (id) ON DELETE NO ACTION;
ALTER TABLE locations ADD CONSTRAINT locations_ref_company_id FOREIGN KEY (company_id) REFERENCES companies (id) ON DELETE CASCADE;
ALTER TABLE routes ADD CONSTRAINT routes_ref_from_stock_id FOREIGN KEY (from_stock_id) REFERENCES stocks (id) ON DELETE NO ACTION;
ALTER TABLE routes ADD CONSTRAINT routes_ref_game_id FOREIGN KEY (game_id) REFERENCES games (id) ON DELETE NO ACTION;
ALTER TABLE routes ADD CONSTRAINT routes_ref_to_stock_id FOREIGN KEY (to_stock_id) REFERENCES stocks (id) ON DELETE NO ACTION;
ALTER TABLE stocks ADD CONSTRAINT stocks_ref_good_id FOREIGN KEY (good_id) REFERENCES goods (id) ON DELETE CASCADE;
ALTER TABLE stocks ADD CONSTRAINT stocks_ref_location_id FOREIGN KEY (location_id) REFERENCES locations (id) ON DELETE CASCADE;

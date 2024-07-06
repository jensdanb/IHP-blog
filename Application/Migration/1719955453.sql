CREATE FUNCTION set_updated_at_to_now() RETURNS TRIGGER AS $$BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;$$ language PLPGSQL;
CREATE TABLE stocks (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    good_id UUID NOT NULL,
    location_id UUID NOT NULL
);
CREATE TABLE companies (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    name TEXT NOT NULL,
    address TEXT[] DEFAULT '{}' NOT NULL
);
CREATE TABLE locations (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    company_id UUID NOT NULL
);
CREATE TABLE routes (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    from_stock_id UUID NOT NULL,
    to_stock_id UUID NOT NULL
);
ALTER TABLE routes ADD CONSTRAINT routes_to_stock_id_key UNIQUE(to_stock_id);
CREATE INDEX companies_created_at_index ON companies (created_at);
CREATE TRIGGER update_companies_updated_at BEFORE UPDATE ON companies FOR EACH ROW EXECUTE FUNCTION set_updated_at_to_now();
CREATE INDEX locations_created_at_index ON locations (created_at);
CREATE TRIGGER update_locations_updated_at BEFORE UPDATE ON locations FOR EACH ROW EXECUTE FUNCTION set_updated_at_to_now();
CREATE INDEX locations_company_id_index ON locations (company_id);
CREATE TABLE goods (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    name TEXT NOT NULL,
    for_sale BOOLEAN DEFAULT false NOT NULL,
    cost INT DEFAULT 0 NOT NULL,
    price INT DEFAULT null
);
CREATE INDEX goods_created_at_index ON goods (created_at);
CREATE TRIGGER update_goods_updated_at BEFORE UPDATE ON goods FOR EACH ROW EXECUTE FUNCTION set_updated_at_to_now();
CREATE INDEX stocks_created_at_index ON stocks (created_at);
CREATE TRIGGER update_stocks_updated_at BEFORE UPDATE ON stocks FOR EACH ROW EXECUTE FUNCTION set_updated_at_to_now();
CREATE INDEX stocks_good_id_index ON stocks (good_id);
CREATE INDEX stocks_location_id_index ON stocks (location_id);
CREATE INDEX routes_created_at_index ON routes (created_at);
ALTER TABLE locations ADD CONSTRAINT locations_ref_company_id FOREIGN KEY (company_id) REFERENCES companies (id) ON DELETE NO ACTION;
ALTER TABLE routes ADD CONSTRAINT routes_ref_from_stock_id FOREIGN KEY (from_stock_id) REFERENCES stocks (id) ON DELETE NO ACTION;
ALTER TABLE routes ADD CONSTRAINT routes_ref_to_stock_id FOREIGN KEY (to_stock_id) REFERENCES stocks (id) ON DELETE NO ACTION;
ALTER TABLE stocks ADD CONSTRAINT stocks_ref_good_id FOREIGN KEY (good_id) REFERENCES goods (id) ON DELETE CASCADE;
ALTER TABLE stocks ADD CONSTRAINT stocks_ref_location_id FOREIGN KEY (location_id) REFERENCES locations (id) ON DELETE CASCADE;

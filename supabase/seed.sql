-- Sample catalogue from supplied HTML. Verify prices, stock, pack sizes and photo rights.
begin;
insert into public.categories(id,name,image,active,sort_order) values
('fruits','Fruits & Vegetables','./products/apples.webp',true,0),
('dairy','Dairy & Milk','./products/amul-milk.webp',true,1),
('rice','Rice & Grains','./products/india-gate-rice.webp',true,2),
('atta','Atta & Flour','./products/aashirvaad-atta.webp',true,3),
('pulses','Pulses','./products/toordal.webp',true,4),
('oil','Oil & Masala','./products/fortune-oil.webp',true,5),
('snacks','Biscuits & Snacks','./products/maggi.webp',true,6),
('beverages','Beverages','./products/tata-tea.webp',true,7),
('chocolates','Chocolates','./products/dairy-milk.webp',true,8),
('bakery','Bakery','./products/modernbread.webp',true,9),
('personal','Personal Care','./products/colgate.webp',true,10),
('household','Household','./products/surf-excel.webp',true,11),
('baby','Baby Care','./products/johnson.webp',true,12),
('frozen','Frozen Foods','',true,13)
on conflict(id) do nothing;
insert into public.products(id,name,brand,category,price,mrp,unit,stock,featured,description,active,image) values
(1,'Amul Milk','Amul','dairy',33,33,'500 ml',80,true,'Fresh toned milk.',true,'./products/amul-milk.webp'),
(2,'Amul Butter','Amul','dairy',56,60,'100 g',40,true,'Creamy salted table butter.',true,'./products/amul-butter.webp'),
(3,'Amul Curd','Amul','dairy',40,44,'400 g',36,false,'Thick, fresh dahi.',true,'./products/curd.webp'),
(4,'Aashirvaad Atta','Aashirvaad','atta',255,280,'5 kg',24,true,'Whole wheat atta for soft rotis.',true,'./products/aashirvaad-atta.webp'),
(5,'India Gate Basmati Rice','India Gate','rice',320,360,'5 kg',20,true,'Long-grain aged basmati rice.',true,'./products/india-gate-rice.webp'),
(6,'Tata Salt','Tata','oil',22,25,'1 kg',60,false,'Iodised free-flow salt.',true,'./products/tata-salt.webp'),
(7,'Fortune Sunflower Oil','Fortune','oil',149,165,'1 L',35,true,'Light refined sunflower oil.',true,'./products/fortune-oil.webp'),
(8,'Tata Tea Gold','Tata','beverages',245,270,'1 kg',28,true,'Rich, aromatic blended tea leaves.',true,'./products/tata-tea.webp'),
(9,'Maggi Noodles','Nestlé','snacks',56,60,'4-pack',90,true,'2-minute masala instant noodles.',true,'./products/maggi.webp'),
(10,'Britannia Good Day','Britannia','snacks',35,40,'250 g',70,false,'Cashew butter cookies.',true,'./products/good-day.webp'),
(11,'Parle-G Biscuits','Parle','snacks',20,22,'200 g',100,false,'Classic glucose biscuits.',true,'./products/parleg.webp'),
(12,'Coca-Cola','Coca-Cola','beverages',45,50,'750 ml',50,false,'Chilled soft drink.',true,'./products/cocacola.webp'),
(13,'Pepsi','Pepsi','beverages',45,50,'750 ml',50,false,'Chilled soft drink.',true,'./products/pepsi.webp'),
(14,'Colgate Strong Teeth','Colgate','personal',89,99,'200 g',55,false,'Cavity protection toothpaste.',true,'./products/colgate.webp'),
(15,'Surf Excel','Surf Excel','household',210,230,'1 kg',32,true,'Removes tough stains.',true,'./products/surf-excel.webp'),
(16,'Fresh Apples','Farm Fresh','fruits',189,210,'1 kg',45,true,'Crisp, hand-picked apples.',true,'./products/apples.webp'),
(17,'Fresh Bananas','Farm Fresh','fruits',49,49,'1 dozen',50,true,'Ripe, naturally sweet bananas.',true,'./products/bananas.webp'),
(18,'Fresh Tomatoes','Farm Fresh','fruits',35,40,'1 kg',40,false,'Juicy farm-fresh tomatoes.',true,'./products/tomatoes.webp'),
(19,'Fresh Potatoes','Farm Fresh','fruits',28,32,'1 kg',55,false,'Everyday cooking potatoes.',true,'./products/potatoes.webp'),
(20,'Fresh Onions','Farm Fresh','fruits',32,36,'1 kg',60,false,'Everyday cooking onions.',true,'./products/onions.webp'),
(21,'Fresh Carrots','Farm Fresh','fruits',38,42,'500 g',30,false,'Crunchy fresh carrots.',true,'./products/carrots.webp'),
(22,'Fresh Oranges','Farm Fresh','fruits',99,110,'1 kg',26,false,'Juicy seasonal oranges.',true,'./products/oranges.webp'),
(23,'Bisleri Water','Bisleri','beverages',20,20,'1 L',70,false,'Packaged drinking water.',true,'./products/bisleri.webp'),
(24,'Dairy Milk Chocolate','Cadbury','chocolates',45,50,'50 g',60,true,'Classic creamy milk chocolate.',true,'./products/dairy-milk.webp'),
(25,'Dettol Handwash','Dettol','personal',99,110,'200 ml',34,false,'Germ protection handwash.',true,'./products/dettol.webp'),
(26,'Lux Soap','Lux','personal',38,42,'3-pack',44,false,'Fragrant beauty soap.',true,'./products/lux.webp'),
(27,'Dove Shampoo','Dove','personal',175,195,'340 ml',26,false,'Nourishing daily shampoo.',true,'./products/dove.webp'),
(28,'Ariel Detergent','Ariel','household',225,250,'1 kg',28,false,'Powerful stain removal powder.',true,'./products/ariel.webp'),
(29,'Vim Dishwash','Vim','household',99,110,'500 ml',30,false,'Lemon-fresh dishwash gel.',true,'./products/vim.webp'),
(30,'Whole Wheat Bread','Modern','bakery',45,48,'400 g',26,true,'Soft, fibre-rich sandwich bread.',true,'./products/modernbread.webp'),
(31,'Toor Dal','Tata Sampann','pulses',145,160,'1 kg',32,false,'Unpolished toor dal.',true,'./products/toordal.webp'),
(32,'Johnson''s Baby Powder','Johnson''s','baby',135,150,'200 g',20,false,'Gentle everyday baby powder.',true,'./products/johnson.webp')
on conflict(id) do nothing;
insert into public.store_settings(id,name,phone,address,city,state,pincode,hours,delivery_fee,free_delivery_threshold,service_pincodes) values (1,'V Mart','081053 24989','Vishwabharati College Road, Near Busstand, Mallasandra','Tumakuru','Karnataka','572107','Open daily · closes around 9:00 PM',30,499,array['572107']) on conflict(id) do nothing;
select setval(pg_get_serial_sequence('public.products','id'),greatest((select max(id) from public.products),1));
commit;

/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\269.gsc
**************************************/

setup_names() {
  if(isDefined(level.names)) {
    return;
  }
  var_0 = [];
  var_0[var_0.size] = "american";
  var_0[var_0.size] = "seal";
  var_0[var_0.size] = "taskforce";
  var_0[var_0.size] = "secretservice";
  var_0[var_0.size] = "british";
  var_0[var_0.size] = "arab";
  var_0[var_0.size] = "russian";
  var_0[var_0.size] = "multilingual";
  var_0[var_0.size] = "portuguese";
  var_0[var_0.size] = "shadowcompany";
  var_0[var_0.size] = "delta";
  var_0[var_0.size] = "french";
  var_0[var_0.size] = "african";
  var_0[var_0.size] = "czech";
  var_0[var_0.size] = "czech_surnames";
  var_0[var_0.size] = "pmc";

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    level.names[var_0[var_1]] = [];
  }
  add_name("american", "Abbott");
  add_name("american", "Abeles");
  add_name("american", "Ackrich");
  add_name("american", "Alvarez");
  add_name("american", "Andaya");
  add_name("american", "Andrew");
  add_name("american", "Arcovitch");
  add_name("american", "Arem");
  add_name("american", "Arya");
  add_name("american", "Audick");
  add_name("american", "Aye");
  add_name("american", "Babichenko");
  add_name("american", "Baker");
  add_name("american", "Bartolucci");
  add_name("american", "Beahm");
  add_name("american", "Bedi");
  add_name("american", "Bein");
  add_name("american", "Bell");
  add_name("american", "Benitez");
  add_name("american", "Berry");
  add_name("american", "Blizard");
  add_name("american", "Blumel");
  add_name("american", "Boon");
  add_name("american", "Bowling");
  add_name("american", "Boyd");
  add_name("american", "Bracamontes");
  add_name("american", "Brooks");
  add_name("american", "Brown");
  add_name("american", "Buchanan");
  add_name("american", "Buckles");
  add_name("american", "Capen");
  add_name("american", "Casey");
  add_name("american", "Cecot");
  add_name("american", "Centkowski");
  add_name("american", "Chan");
  add_name("american", "Chang");
  add_name("american", "Chen");
  add_name("american", "Chew");
  add_name("american", "Chu");
  add_name("american", "Chyo");
  add_name("american", "Cinquegrano");
  add_name("american", "Clark");
  add_name("american", "Condrey");
  add_name("american", "Conteras");
  add_name("american", "Cournoyer");
  add_name("american", "Curley");
  add_name("american", "Daley");
  add_name("american", "David");
  add_name("american", "Davis");
  add_name("american", "DeBolt");
  add_name("american", "DeMartini");
  add_name("american", "Denny");
  add_name("american", "Deonarine");
  add_name("american", "DeRidder");
  add_name("american", "Desmarais");
  add_name("american", "DiMeo");
  add_name("american", "Dobbie");
  add_name("american", "Dohr");
  add_name("american", "Dolan");
  add_name("american", "Drinkward");
  add_name("american", "Dye");
  add_name("american", "Eady");
  add_name("american", "Evans");
  add_name("american", "Feinberg");
  add_name("american", "Felker");
  add_name("american", "Field");
  add_name("american", "Fong");
  add_name("american", "Ganus");
  add_name("american", "Gavazza");
  add_name("american", "Gavrisheff");
  add_name("american", "Gevorkian");
  add_name("american", "Giesler");
  add_name("american", "Gil");
  add_name("american", "Glasco");
  add_name("american", "Goldsworthy");
  add_name("american", "Griffith");
  add_name("american", "Gu");
  add_name("american", "Guaman");
  add_name("american", "Gunasingam");
  add_name("american", "Hall");
  add_name("american", "Halon");
  add_name("american", "Harmer");
  add_name("american", "Harries");
  add_name("american", "Harris");
  add_name("american", "Haugen");
  add_name("american", "Haworth");
  add_name("american", "Hazelroth");
  add_name("american", "Heath");
  add_name("american", "Hirsh");
  add_name("american", "Holmes");
  add_name("american", "Hook");
  add_name("american", "Hudson");
  add_name("american", "Imai");
  add_name("american", "Jeffries");
  add_name("american", "Johnson");
  add_name("american", "Katz");
  add_name("american", "Keiser");
  add_name("american", "Kelvin");
  add_name("american", "Kinney");
  add_name("american", "Kriegler");
  add_name("american", "Kuhn");
  add_name("american", "Kuo");
  add_name("american", "Kwak");
  add_name("american", "Lai");
  add_name("american", "Lam");
  add_name("american", "Lamperski");
  add_name("american", "Lane");
  add_name("american", "Leal");
  add_name("american", "Lee");
  add_name("american", "Liang");
  add_name("american", "Lie");
  add_name("american", "Lin");
  add_name("american", "Lodato");
  add_name("american", "Longland");
  add_name("american", "Lopez");
  add_name("american", "Lor");
  add_name("american", "Louie");
  add_name("american", "Luo");
  add_name("american", "Luyties");
  add_name("american", "Madrid");
  add_name("american", "Mai");
  add_name("american", "McDonald");
  add_name("american", "McEntyre");
  add_name("american", "McGrath");
  add_name("american", "McGree");
  add_name("american", "McLeran");
  add_name("american", "Mermelstein");
  add_name("american", "Miller");
  add_name("american", "Munson");
  add_name("american", "Myers");
  add_name("american", "Naas");
  add_name("american", "Nacu");
  add_name("american", "Nahashon");
  add_name("american", "Neel");
  add_name("american", "O'Connor");
  add_name("american", "O'Hara");
  add_name("american", "Onur");
  add_name("american", "Pacheco");
  add_name("american", "Pavey");
  add_name("american", "Pavlich");
  add_name("american", "Peacher");
  add_name("american", "Peas");
  add_name("american", "Pelayo");
  add_name("american", "Pennya");
  add_name("american", "Pierce");
  add_name("american", "Pineda");
  add_name("american", "Pitts");
  add_name("american", "Porter");
  add_name("american", "Proudfoot");
  add_name("american", "Reisdorf");
  add_name("american", "Robbins");
  add_name("american", "Rowell");
  add_name("american", "Rubin");
  add_name("american", "Ruiz");
  add_name("american", "Ryu");
  add_name("american", "Sahas");
  add_name("american", "Salud");
  add_name("american", "Sanborn");
  add_name("american", "Sandler");
  add_name("american", "Sarkisyan");
  add_name("american", "Schmill");
  add_name("american", "Schofield");
  add_name("american", "Shande");
  add_name("american", "Sharp");
  add_name("american", "Shellikeri");
  add_name("american", "Shepherd");
  add_name("american", "Sheu");
  add_name("american", "Sidey");
  add_name("american", "Silvers");
  add_name("american", "Simas");
  add_name("american", "Smith");
  add_name("american", "Soucy");
  add_name("american", "Sperry");
  add_name("american", "Staples");
  add_name("american", "Stone");
  add_name("american", "Stoughton");
  add_name("american", "Strickland");
  add_name("american", "Suarez");
  add_name("american", "SullivanLee");
  add_name("american", "Swenson");
  add_name("american", "T");
  add_name("american", "Taehoon");
  add_name("american", "Tang");
  add_name("american", "Turner");
  add_name("american", "Veca");
  add_name("american", "Vitalone");
  add_name("american", "Volker");
  add_name("american", "Vuong");
  add_name("american", "Wapner");
  add_name("american", "Wasilczyk");
  add_name("american", "Webb");
  add_name("american", "West");
  add_name("american", "Whelpley");
  add_name("american", "Whitney");
  add_name("american", "Whitten");
  add_name("american", "Wrede");
  add_name("american", "Wright");
  add_name("american", "Yang");
  add_name("american", "Zaiya");
  add_name("american", "Zaring");
  add_name("american", "Zipkin");
  add_name("seal", "Angel");
  add_name("seal", "Apex");
  add_name("seal", "Bearcat");
  add_name("seal", "Bishop");
  add_name("seal", "Boomer");
  add_name("seal", "Boxer");
  add_name("seal", "Canine");
  add_name("seal", "Chemist");
  add_name("seal", "Chemo");
  add_name("seal", "Cherub");
  add_name("seal", "Chino");
  add_name("seal", "Coffin");
  add_name("seal", "Coma");
  add_name("seal", "Cyclops");
  add_name("seal", "Cypher");
  add_name("seal", "Doc");
  add_name("seal", "Druid");
  add_name("seal", "Exxon");
  add_name("seal", "Gator");
  add_name("seal", "Hannibal");
  add_name("seal", "Hazard");
  add_name("seal", "Hitman");
  add_name("seal", "Jayhawk");
  add_name("seal", "Jester");
  add_name("seal", "Justice");
  add_name("seal", "Klepto");
  add_name("seal", "Kojak");
  add_name("seal", "Langley");
  add_name("seal", "Neptune");
  add_name("seal", "Mamba");
  add_name("seal", "Midnight");
  add_name("seal", "Neon");
  add_name("seal", "Nomad");
  add_name("seal", "Ogre");
  add_name("seal", "Ozone");
  add_name("seal", "Patron");
  add_name("seal", "Pharaoh");
  add_name("seal", "Pieces");
  add_name("seal", "Poet");
  add_name("seal", "Preacher");
  add_name("seal", "Reaper");
  add_name("seal", "Redcell");
  add_name("seal", "Roadie");
  add_name("seal", "Robot");
  add_name("seal", "Rocket");
  add_name("seal", "Rooster");
  add_name("seal", "Sparrow");
  add_name("seal", "Taco");
  add_name("seal", "Thumper");
  add_name("seal", "Trojan");
  add_name("seal", "Twister");
  add_name("seal", "Undertone");
  add_name("seal", "Utah");
  add_name("seal", "Whiskey");
  add_name("seal", "Worm");
  add_name("seal", "Yankee");
  add_name("seal", "Zero");
  copy_names("taskforce", "seal");
  copy_names("delta", "seal");
  add_name("secretservice", "Smith");
  add_name("secretservice", "Jones");
  add_name("secretservice", "Jackson");
  add_name("secretservice", "Johnson");
  add_name("secretservice", "Thompson");
  add_name("secretservice", "Ash");
  add_name("secretservice", "Bird");
  add_name("secretservice", "Finn");
  add_name("secretservice", "Fine");
  add_name("secretservice", "Brown");
  add_name("secretservice", "White");
  add_name("secretservice", "Gray");
  add_name("secretservice", "Black");
  add_name("secretservice", "Wylie");
  add_name("secretservice", "Rosenhaus");
  add_name("secretservice", "Boras");
  add_name("secretservice", "McKinnis");
  add_name("secretservice", "Duffy");
  add_name("secretservice", "Falk");
  add_name("secretservice", "Tellem");
  add_name("secretservice", "Goodwin");
  add_name("secretservice", "Condon");
  add_name("secretservice", "Parker");
  add_name("secretservice", "McGuire");
  add_name("secretservice", "Steinberg");
  add_name("british", "Abbot");
  add_name("british", "Adams");
  add_name("british", "Bartlett");
  add_name("british", "Boyd");
  add_name("british", "Boyle");
  add_name("british", "Bremner");
  add_name("british", "Carlyle");
  add_name("british", "Carver");
  add_name("british", "Cheek");
  add_name("british", "Clarke");
  add_name("british", "Collins");
  add_name("british", "Compton");
  add_name("british", "Connolly");
  add_name("british", "Cook");
  add_name("british", "Dowd");
  add_name("british", "Field");
  add_name("british", "Fleming");
  add_name("british", "Fletcher");
  add_name("british", "Flynn");
  add_name("british", "Grant");
  add_name("british", "Greaves");
  add_name("british", "Harris");
  add_name("british", "Harrison");
  add_name("british", "Heath");
  add_name("british", "Henderson");
  add_name("british", "Hopkins");
  add_name("british", "Hoyt");
  add_name("british", "Kent");
  add_name("british", "Lewis");
  add_name("british", "Lipton");
  add_name("british", "Macdonald");
  add_name("british", "Maxwell");
  add_name("british", "McQuarrie");
  add_name("british", "Miller");
  add_name("british", "Mitchell");
  add_name("british", "Moore");
  add_name("british", "Murphy");
  add_name("british", "Murray");
  add_name("british", "Pearce");
  add_name("british", "Plumber");
  add_name("british", "Pritchard");
  add_name("british", "Rankin");
  add_name("british", "Reed");
  add_name("british", "Ritchie");
  add_name("british", "Ross");
  add_name("british", "Roth");
  add_name("british", "Smith");
  add_name("british", "Stevenson");
  add_name("british", "Stuart");
  add_name("british", "Sullivan");
  add_name("british", "Thompson");
  add_name("british", "Veale");
  add_name("british", "Wallace");
  add_name("british", "Wells");
  add_name("british", "Welsh");
  add_name("russian", "Sasha Ivanov");
  add_name("russian", "Aleksei Vyshinskiy");
  add_name("russian", "Boris Ryzhkov");
  add_name("russian", "Dima Tikhonov");
  add_name("russian", "Oleg Kosygin");
  add_name("russian", "Pyotr Bulganin");
  add_name("russian", "Petya Malenkov");
  add_name("russian", "Alyosha Tarkovsky");
  add_name("russian", "Sergei Grombyo");
  add_name("russian", "Viktor Kuznetsov");
  add_name("russian", "Misha Podgorniy");
  add_name("russian", "Borya Mikoyan");
  add_name("russian", "Anatoly Voroshilov");
  add_name("russian", "Kolya Shvernik");
  add_name("russian", "Nikolai Kalinin");
  add_name("russian", "Vladimir Brezhnev");
  add_name("russian", "Pavel Chernenko");
  add_name("russian", "Volodya Andropov");
  add_name("russian", "Yuri Nikitin");
  add_name("russian", "Dmitri Petrenko");
  add_name("russian", "Vanya Gerasimov");
  add_name("russian", "Mikhail Zhuravlev");
  add_name("russian", "Ivan Lukin");
  add_name("russian", "Kostya Golubev");
  add_name("russian", "Konstantin Lebedev");
  add_name("russian", "Aleksandr Vasilev");
  add_name("russian", "Yakov Glushenko");
  add_name("russian", "Sasha Semenov");
  add_name("russian", "Aleksei Ulyanov");
  add_name("russian", "Boris Yefremov");
  add_name("russian", "Dima Chernyshenko");
  add_name("russian", "Oleg Stepanoshvili");
  add_name("russian", "Pyotr Demchenko");
  add_name("russian", "Petya Avagimov");
  add_name("russian", "Alyosha Murzaev");
  add_name("russian", "Sergei Shkuratov");
  add_name("russian", "Viktor Yakimenko");
  add_name("russian", "Misha Masijashvili");
  add_name("russian", "Borya Shapovalov");
  add_name("russian", "Anatoly Ivashenko");
  add_name("russian", "Kolya Dovzhenko");
  add_name("russian", "Nikolai Turdyev");
  add_name("russian", "Vladimir Sabgaida");
  add_name("russian", "Pavel Svirin");
  add_name("russian", "Volodya Sarayev");
  add_name("russian", "Yuri Kiselev");
  add_name("russian", "Dmitri Bondarenko");
  add_name("russian", "Vanya Chernogolov");
  add_name("russian", "Mikhail Voronov");
  add_name("russian", "Ivan Afanasyev");
  add_name("russian", "Kostya Gridin");
  add_name("russian", "Konstantin Petrov");
  add_name("russian", "Aleksandr Rykov");
  add_name("russian", "Yakov Shvedov");
  add_name("arab", "Abdulaziz");
  add_name("arab", "Abdullah");
  add_name("arab", "Ali");
  add_name("arab", "Amin");
  add_name("arab", "Bassam");
  add_name("arab", "Fahd");
  add_name("arab", "Faris");
  add_name("arab", "Fouad");
  add_name("arab", "Habib");
  add_name("arab", "Hakem");
  add_name("arab", "Hassan");
  add_name("arab", "Ibrahim");
  add_name("arab", "Imad");
  add_name("arab", "Jabbar");
  add_name("arab", "Kareem");
  add_name("arab", "Khalid");
  add_name("arab", "Malik");
  add_name("arab", "Muhammad");
  add_name("arab", "Nasir");
  add_name("arab", "Omar");
  add_name("arab", "Rafiq");
  add_name("arab", "Rami");
  add_name("arab", "Said");
  add_name("arab", "Salim");
  add_name("arab", "Samir");
  add_name("arab", "Talib");
  add_name("arab", "Tariq");
  add_name("arab", "Youssef");
  add_name("arab", "Ziad");
  add_name("portuguese", "Carlitos");
  add_name("portuguese", "Antonio");
  add_name("portuguese", "Gervasio");
  add_name("portuguese", "Lois");
  add_name("portuguese", "Xesus");
  add_name("shadowcompany", "Lestat");
  add_name("shadowcompany", "Nosferatu");
  add_name("shadowcompany", "Lecter");
  add_name("multilingual", "Kugelschreiber");
  add_name("multilingual", "Flughafen");
  add_name("french", "Astor");
  add_name("french", "Beliveau");
  add_name("french", "Chaloux");
  add_name("french", "Leboeuf");
  add_name("french", "Leblanc");
  add_name("french", "Navarre");
  add_name("french", "Perilloux");
  add_name("french", "Philippe");
  add_name("french", "Taillon");
  add_name("african", "Sulaiman");
  add_name("african", "Camara");
  add_name("african", "Mustapha");
  add_name("african", "Abubakarr");
  add_name("czech", "Andrej");
  add_name("czech", "Anton");
  add_name("czech", "Antonin");
  add_name("czech", "Arnost");
  add_name("czech", "Augustin");
  add_name("czech", "Bartolomej");
  add_name("czech", "Beda");
  add_name("czech", "Bedrich");
  add_name("czech", "Benes");
  add_name("czech", "Blaze");
  add_name("czech", "Bohdan");
  add_name("czech", "Bohuslav");
  add_name("czech", "Bonifác");
  add_name("czech", "Bozidar");
  add_name("czech", "Branislav");
  add_name("czech", "Cenek");
  add_name("czech", "Ctibor");
  add_name("czech", "Dalek");
  add_name("czech", "Dalibor");
  add_name("czech", "Damek");
  add_name("czech", "Danek");
  add_name("czech", "Dávid");
  add_name("czech", "Dobromil");
  add_name("czech", "Dominik");
  add_name("czech", "Drahoslav");
  add_name("czech", "Dusa");
  add_name("czech", "Edvard");
  add_name("czech", "Eliás");
  add_name("czech", "Evzen");
  add_name("czech", "Frantisek");
  add_name("czech", "Gabriel");
  add_name("czech", "Georg");
  add_name("czech", "Holic");
  add_name("czech", "Honza");
  add_name("czech", "Ignác");
  add_name("czech", "Imrich");
  add_name("czech", "Ivan");
  add_name("czech", "Jakub");
  add_name("czech", "Jan");
  add_name("czech", "Jarmil");
  add_name("czech", "Jaroslav");
  add_name("czech", "Jindrich");
  add_name("czech", "Jiri");
  add_name("czech", "Johan");
  add_name("czech", "Josef");
  add_name("czech", "Július");
  add_name("czech", "Juraj");
  add_name("czech", "Kamil");
  add_name("czech", "Konstantin");
  add_name("czech", "Kopecký");
  add_name("czech", "Kornel");
  add_name("czech", "Kristof");
  add_name("czech", "Ladislav");
  add_name("czech", "Leos");
  add_name("czech", "Libor");
  add_name("czech", "Ludvik");
  add_name("czech", "Lukás");
  add_name("czech", "Marek");
  add_name("czech", "Matej");
  add_name("czech", "Matous");
  add_name("czech", "Matus");
  add_name("czech", "Michal");
  add_name("czech", "Mikulás");
  add_name("czech", "Milan");
  add_name("czech", "Milos");
  add_name("czech", "Mirek");
  add_name("czech", "Miroslav");
  add_name("czech", "Nikola");
  add_name("czech", "Oldrich");
  add_name("czech", "Ondrej");
  add_name("czech", "Otakar");
  add_name("czech", "Patrik");
  add_name("czech", "Pavel");
  add_name("czech", "Petr");
  add_name("czech", "Premysl");
  add_name("czech", "Radek");
  add_name("czech", "Radim");
  add_name("czech", "Radoslav");
  add_name("czech", "Rehor");
  add_name("czech_surnames", "Blumel");
  add_name("czech_surnames", "Maly");
  add_name("czech_surnames", "Pospisil");
  add_name("czech_surnames", "Soukup");
  add_name("czech_surnames", "Blazek");
  add_name("czech_surnames", "Dolezal");
  add_name("czech_surnames", "Fiser");
  add_name("czech_surnames", "Kadlec");
  add_name("czech_surnames", "Kolar");
  add_name("czech_surnames", "Kopecky");
  add_name("czech_surnames", "Kriz");
  add_name("czech_surnames", "Mares");
  add_name("czech_surnames", "Masek");
  add_name("czech_surnames", "Polak");
  add_name("czech_surnames", "Sedlacek");
  add_name("czech_surnames", "Stastny");
  add_name("czech_surnames", "Tuma");
  add_name("czech_surnames", "Vanek");
  add_name("czech_surnames", "Blaha");
  add_name("czech_surnames", "Dusek");
  add_name("czech_surnames", "Hruska");
  add_name("czech_surnames", "Janda");
  add_name("czech_surnames", "Kohout");
  add_name("czech_surnames", "Matousek");
  add_name("czech_surnames", "Moravec");
  add_name("czech_surnames", "Mueller");
  add_name("czech_surnames", "Riha");
  add_name("czech_surnames", "Strnad");
  add_name("czech_surnames", "Sykora");
  add_name("czech_surnames", "Simek");
  add_name("czech_surnames", "Smid");
  add_name("czech_surnames", "Stepanek");
  add_name("czech_surnames", "Tichy");
  add_name("czech_surnames", "Vacek");
  add_name("czech_surnames", "Vlcek");
  copy_names("pmc", "czech_surnames");
  init_script_friendnames();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    remove_script_friendnames_from_list(var_0[var_1]);
    randomize_name_list(var_0[var_1]);
    level.nameindex[var_0[var_1]] = 0;
  }
}

copy_names(var_0, var_1) {
  level.names[var_0] = level.names[var_1];
}

add_name(var_0, var_1) {
  level.names[var_0][level.names[var_0].size] = var_1;
}

remove_name(var_0, var_1) {
  level.names[var_0] = common_scripts\utility::array_remove(level.names[var_0], var_1);
}

init_script_friendnames() {
  var_0 = [];
  var_1 = getspawnerarray();
  var_2 = getaiarray();

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_friendname) && var_4.script_friendname != "none") {
      var_5 = normalize_script_friendname(var_4.script_friendname);
      var_0[var_0.size] = var_5;
    }
  }

  foreach(var_8 in var_2) {
    if(isDefined(var_8.script_friendname) && var_8.script_friendname != "none") {
      var_5 = normalize_script_friendname(var_8.script_friendname);
      var_0[var_0.size] = var_5;
    }
  }

  level.script_friendnames = var_0;
}

normalize_script_friendname(var_0) {
  var_1 = strtok(var_0, " ");

  if(var_1.size > 1) {
    var_0 = var_1[1];
  }
  return var_0;
}

remove_script_friendnames_from_list(var_0) {
  foreach(var_2 in level.script_friendnames) {
    foreach(var_4 in level.names[var_0]) {
      if(var_2 == var_4) {
        remove_name(var_0, var_4);
      }
    }
  }
}

randomize_name_list(var_0) {
  var_1 = level.names[var_0].size;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = randomint(var_1);
    var_4 = level.names[var_0][var_2];
    level.names[var_0][var_2] = level.names[var_0][var_3];
    level.names[var_0][var_3] = var_4;
  }
}

get_name(var_0) {
  if(isDefined(self.team) && self.team == "neutral") {
    return;
  }
  if(!isDefined(var_0) && level.script == "credits") {
    self.airank = "private";
    return;
  }

  if(isDefined(self.script_friendname)) {
    if(self.script_friendname == "none") {
      return;
    }
    self.name = self.script_friendname;
    getrankfromname(self.name);
    self notify("set name and rank");
    return;
  }

  get_name_for_nationality(self.voice);
  self notify("set name and rank");
}

get_name_for_nationality(var_0) {
  level.nameindex[var_0] = (level.nameindex[var_0] + 1) % level.names[var_0].size;
  var_1 = level.names[var_0][level.nameindex[var_0]];
  var_2 = randomint(10);

  if(nationalityusessurnames(var_0)) {
    var_3 = var_0 + "_surnames";
    level.nameindex[var_3] = (level.nameindex[var_3] + 1) % level.names[var_3].size;
    var_1 = var_1 + " " + level.names[var_3][level.nameindex[var_3]];
  }

  if(nationalityusescallsigns(var_0)) {
    var_4 = var_1;
    self.airank = "private";
  } else if(var_0 == "secretservice") {
    var_4 = "Agent " + var_1;
    self.airank = "private";
  } else if(var_2 > 5) {
    var_4 = "Pvt. " + var_1;
    self.airank = "private";
  } else if(var_2 > 2) {
    var_4 = "Cpl. " + var_1;
    self.airank = "private";
  } else {
    var_4 = "Sgt. " + var_1;
    self.airank = "sergeant";
  }

  if(isai(self) && self isbadguy()) {
    self.ainame = var_4;
  } else {
    self.name = var_4;
  }
}

getrankfromname(var_0) {
  if(!isDefined(var_0)) {
    self.airank = "private";
  }
  var_1 = strtok(var_0, " ");
  var_2 = var_1[0];

  switch (var_2) {
    case "Pvt.":
      self.airank = "private";
      break;
    case "Pfc.":
      self.airank = "private";
      break;
    case "Agent":
      self.airank = "private";
      break;
    case "Cpl.":
      self.airank = "corporal";
      break;
    case "Sgt.":
      self.airank = "sergeant";
      break;
    case "Lt.":
      self.airank = "lieutenant";
      break;
    case "Cpt.":
      self.airank = "captain";
      break;
    default:
      self.airank = "private";
      break;
  }
}

nationalityusescallsigns(var_0) {
  switch (var_0) {
    case "seal":
    case "taskforce":
    case "czech":
    case "delta":
      return 1;
  }

  return 0;
}

nationalityusessurnames(var_0) {
  return isDefined(level.names[var_0 + "_surnames"]);
}
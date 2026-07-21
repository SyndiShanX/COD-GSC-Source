/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\extraction\cp_extraction.gsc
***********************************************/

main() {
  register_extraction_interactions();
  script_model_exfil_anims();
  level.averagealliesz = 0;
  level.extraction_func = ::blank;
  level.extraction_uses = 0;
  level.extraction_cooldown = 30 + 10 * level.extraction_uses;
  level.time_till_next_extraction = level.extraction_cooldown;

  if(!isDefined(level.extraction_vehicles))
    level.extraction_vehicles = [];
}

blank() {}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

script_model_exfil_anims() {
  level.scr_animtree["_encstr_A266062032BD7723"] = #animtree;
  level.scr_anim["_encstr_A266062032BD7723"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = % _encstr_8ECF1882C83763C35EB301889D3D2B73051067901F8309112843;
  level.scr_animname["_encstr_A266062032BD7723"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = "_encstr_8ECF1882C83763C35EB301889D3D2B73051067901F8309112843";
  level.scr_animtree["_encstr_A266062032BD7723"] = #animtree;
  level.scr_anim["_encstr_A266062032BD7723"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = % _encstr_837A1D8D0119BC53DCD83AF18026EB7688970709C708C403705301CAC8889B;
  level.scr_animname["_encstr_A266062032BD7723"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = "_encstr_837A1D8D0119BC53DCD83AF18026EB7688970709C708C403705301CAC8889B";
  level.scr_animtree["_encstr_A266062032BD7723"] = #animtree;
  level.scr_anim["_encstr_A266062032BD7723"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = % _encstr_8ACB22159981243BB4A05269289E739E603FAF61AFA06CFBE8FB7962506033D92BB901FC;
  level.scr_animname["_encstr_A266062032BD7723"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = "_encstr_8ACB22159981243BB4A05269289E739E603FAF61AFA06CFBE8FB7962506033D92BB901FC";
  level.scr_animtree["_encstr_9B7408BFEF17BA445893"] = #animtree;
  level.scr_anim["_encstr_9B7408BFEF17BA445893"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = % _encstr_8C0E1A85D321B132FC1B73C76996BBF13098B10EAE284F0B43397763;
  level.scr_animname["_encstr_9B7408BFEF17BA445893"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = "_encstr_8C0E1A85D321B132FC1B73C76996BBF13098B10EAE284F0B43397763";
  level.scr_animtree["_encstr_9B7408BFEF17BA445893"] = #animtree;
  level.scr_anim["_encstr_9B7408BFEF17BA445893"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = % _encstr_86C11FA99A814A37238A59BEC11E5BC9FB4879A93F73DF4158344F78407940BF88;
  level.scr_animname["_encstr_9B7408BFEF17BA445893"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = "_encstr_86C11FA99A814A37238A59BEC11E5BC9FB4879A93F73DF4158344F78407940BF88";
  level.scr_animtree["_encstr_9B7408BFEF17BA445893"] = #animtree;
  level.scr_anim["_encstr_9B7408BFEF17BA445893"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = % _encstr_835B24384AAFEA95A2B285B7A29EAEF72390A983DE63E5226BBCBF439158A718939087C99979;
  level.scr_animname["_encstr_9B7408BFEF17BA445893"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = "_encstr_835B24384AAFEA95A2B285B7A29EAEF72390A983DE63E5226BBCBF439158A718939087C99979";
  level.scr_animtree["_encstr_A2FF07DB605823217A"] = #animtree;
  level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = % _encstr_A1011A6B07D796CD33D236AF8D31C9B09D7BEBB0FAB3AEBCC4F5EED6;
  level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = "_encstr_A1011A6B07D796CD33D236AF8D31C9B09D7BEBB0FAB3AEBCC4F5EED6";
  level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = "_encstr_B1A81117184C12BB7160734D901DE8CFE1EFAF";
  level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_99741258761D395D47D9C84323F0F4293D3382EB"] = % _encstr_A9BB1FD20BA8AF9520CB4C77E928DAD76480899A761C178862BF7D489BC0A94701;
  level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_99741258761D395D47D9C84323F0F4293D3382EB"] = "_encstr_A9BB1FD20BA8AF9520CB4C77E928DAD76480899A761C178862BF7D489BC0A94701";
  level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_99741258761D395D47D9C84323F0F4293D3382EB"] = "_encstr_826C1681D02947C567B0EAE3B05D7DE7A1D01518FBB3575A";
  level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = % _encstr_AF281F503BE99388D33961F004FB334B0B5249C8213F1322E66779D0EF5B5E3FB5;
  level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = "_encstr_AF281F503BE99388D33961F004FB334B0B5249C8213F1322E66779D0EF5B5E3FB5";
  level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = "_encstr_A97D16F3E20F1804595A721ADF25675698F6B0DF2AAF198F";
  level.scr_anim["_encstr_A2FF07DB605823217A"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = % _encstr_950F248369897338238FD1B1E89BF3E14DB80108C1884063820109AA28CB19EDD80A5B50AF0D;
  level.scr_animname["_encstr_A2FF07DB605823217A"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = "_encstr_950F248369897338238FD1B1E89BF3E14DB80108C1884063820109AA28CB19EDD80A5B50AF0D";
  level.scr_eventanim["_encstr_A2FF07DB605823217A"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = "_encstr_87801B230DF2438DD73368E0EF16B8F72AF929B825EB6769C83F209196";
  level.scr_animtree["_encstr_95FF079B8D7B1DFA4C"] = #animtree;
  level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = % _encstr_ADEB1A23304783B09558FCF15D6BA05193BDC8A180B7D36012F73F42;
  level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = "_encstr_ADEB1A23304783B09558FCF15D6BA05193BDC8A180B7D36012F73F42";
  level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = "_encstr_BAA81158ED1E3049713B557D27CBB739B109AB";
  level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_99741258761D395D47D9C84323F0F4293D3382EB"] = % _encstr_B8431FF952B99B88269F50D1937A43C3933D787761D27B525A2F10E0AF843E574A;
  level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_99741258761D395D47D9C84323F0F4293D3382EB"] = "_encstr_B8431FF952B99B88269F50D1937A43C3933D787761D27B525A2F10E0AF843E574A";
  level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_99741258761D395D47D9C84323F0F4293D3382EB"] = "_encstr_926C16331DE253F027C378F0DF26A8873AC9BDC3B49B77F3";
  level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = % _encstr_A7391FAD1CFAB4CD33A58DFAC613E4B0ECB77D58BE3BD5BC467D1BB7B7E0D7DDD6;
  level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = "_encstr_A7391FAD1CFAB4CD33A58DFAC613E4B0ECB77D58BE3BD5BC467D1BB7B7E0D7DDD6";
  level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = "_encstr_AF7D16B05D4EDB026654D6E2A7C86701C9E9802017DAE125";
  level.scr_anim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = % _encstr_960824D850E1C31A69E2AA203929C59F6C68494776CAC8F80AA93108750B297173078B4EFB7B;
  level.scr_animname["_encstr_95FF079B8D7B1DFA4C"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = "_encstr_960824D850E1C31A69E2AA203929C59F6C68494776CAC8F80AA93108750B297173078B4EFB7B";
  level.scr_eventanim["_encstr_95FF079B8D7B1DFA4C"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = "_encstr_96801B20CD47C301AF382233C7F050AE7756190F42707E8D29C0F139F6";
  level.scr_animtree["_encstr_BAFF07CD367B1DD791"] = #animtree;
  level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = % _encstr_8CF01AF05BC7B84DEADC49D87542BD61368FD9187F97733B87493CD9;
  level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = "_encstr_8CF01AF05BC7B84DEADC49D87542BD61368FD9187F97733B87493CD9";
  level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = "_encstr_A9A811883DCEE099410B052D57BB500961D97B";
  level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_99741258761D395D47D9C84323F0F4293D3382EB"] = % _encstr_8E261F5B1CBE4BDC3396C6FAB18939589DED7DC2FA3B5DF299BEB21E4B8EFAEEDA;
  level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_99741258761D395D47D9C84323F0F4293D3382EB"] = "_encstr_8E261F5B1CBE4BDC3396C6FAB18939589DED7DC2FA3B5DF299BEB21E4B8EFAEEDA";
  level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_99741258761D395D47D9C84323F0F4293D3382EB"] = "_encstr_BE6C162D3733D2C6FAC6C4E40B677BD72CAF9587D28ED766";
  level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = % _encstr_81C51FDA83EBA57399B436EBD8314E859DBDAF58F5D95DE5CCD71BDEB738AF77AD;
  level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = "_encstr_81C51FDA83EBA57399B436EBD8314E859DBDAF58F5D95DE5CCD71BDEB738AF77AD";
  level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = "_encstr_9A7D162DDC335AC6BEB1139C0BECB7AF0BEB1BB7DBE07D33";
  level.scr_anim["_encstr_BAFF07CD367B1DD791"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = % _encstr_B81D24B60EFA96B9665AB1EB1B313985CEF67DC2BED9D5F266D78DF6F6077D56E14B8EF5BBAD;
  level.scr_animname["_encstr_BAFF07CD367B1DD791"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = "_encstr_B81D24B60EFA96B9665AB1EB1B313985CEF67DC2BED9D5F266D78DF6F6077D56E14B8EF5BBAD";
  level.scr_eventanim["_encstr_BAFF07CD367B1DD791"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = "_encstr_88801B967399A51BFAC6262758D9F6EB167D36BDF6C1BE95E1B4E8F533";
  level.scr_animtree["_encstr_B1FF077B0D77B8B017"] = #animtree;
  level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = % _encstr_8BD81A1543B121A20CEB8357F9262B614008019E5E98E5EB7DEFE797;
  level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = "_encstr_8BD81A1543B121A20CEB8357F9262B614008019E5E98E5EB7DEFE797";
  level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = "_encstr_A6A81144A30FFF59E103EA236A63A5E9EA0F43";
  level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_99741258761D395D47D9C84323F0F4293D3382EB"] = % _encstr_A9F91F8922C9EBF8568F40E1A36AB333830D680771E26B426C3F2BD05F942E475A;
  level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_99741258761D395D47D9C84323F0F4293D3382EB"] = "_encstr_A9F91F8922C9EBF8568F40E1A36AB333830D680771E26B426C3F2BD05F942E475A";
  level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_99741258761D395D47D9C84323F0F4293D3382EB"] = "_encstr_816C161B9ED46B094F3BC2D0B10327C9EF57B9E8A314192B";
  level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = % _encstr_B2851F4A938994C5835C695FA9C595EF807BE9E126C4930BBDD73C40153828B75D;
  level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = "_encstr_B2851F4A938994C5835C695FA9C595EF807BE9E126C4930BBDD73C40153828B75D";
  level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = "_encstr_A27D169CF0055ABC3EB86B23F83367E1E3802595E89171AC";
  level.scr_anim["_encstr_B1FF077B0D77B8B017"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = % _encstr_8DFA24C290AF54B3C94B94AFD1911B9E55D0699A81A70BA7ABB86C8778BBE727910863F1581B;
  level.scr_animname["_encstr_B1FF077B0D77B8B017"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = "_encstr_8DFA24C290AF54B3C94B94AFD1911B9E55D0699A81A70BA7ABB86C8778BBE727910863F1581B";
  level.scr_eventanim["_encstr_B1FF077B0D77B8B017"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = "_encstr_81801BAA48F56C83C611426ABFCB473923290242D871A9FF5A8B5C4FED";
  level.scr_animtree["_encstr_A6FF0747907B08963F"] = #animtree;
  level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = % _encstr_A1DF1A3B3A2FBFA39A90816970F122360CB5778FF1C15DC8326F5728;
  level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = "_encstr_A1DF1A3B3A2FBFA39A90816970F122360CB5778FF1C15DC8326F5728";
  level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = "_encstr_B6A8115ACD33D263F53689C958B3DBD70BBEA9";
  level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_99741258761D395D47D9C84323F0F4293D3382EB"] = % _encstr_AD1C1FA81A57403872BFF997831A7E5816B596A149D7686BBF7FD3C1EF23D020D5;
  level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_99741258761D395D47D9C84323F0F4293D3382EB"] = "_encstr_AD1C1FA81A57403872BFF997831A7E5816B596A149D7686BBF7FD3C1EF23D020D5";
  level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_99741258761D395D47D9C84323F0F4293D3382EB"] = "_encstr_886C16D2CD99B436FA36139C853BED7DB07D591E4B1D7D9A";
  level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = % _encstr_8B651FB507AF4BDCCC5AB1AFC6C4C9B067EDD785F5EC5DE5A67D8DDBDB83EBEEDA;
  level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = "_encstr_8B651FB507AF4BDCCC5AB1AFC6C4C9B067EDD785F5EC5DE5A67D8DDBDB83EBEEDA";
  level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = "_encstr_957D1629AB23E4DAC15DEB5B873338617029B260680BC04D";
  level.scr_anim["_encstr_A6FF0747907B08963F"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = % _encstr_96EC246B837D5A37992DC6F5D89893C267DBEBB0AFD9EAF2D4BE637BBD1CEB2B3C96D1AFEEAD;
  level.scr_animname["_encstr_A6FF0747907B08963F"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = "_encstr_96EC246B837D5A37992DC6F5D89893C267DBEBB0AFD9EAF2D4BE637BBD1CEB2B3C96D1AFEEAD";
  level.scr_eventanim["_encstr_A6FF0747907B08963F"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = "_encstr_AA801B517BD1ABFD3728FD23273B82B777F9B9F070EB0F472A2A1B2163";
  level.scr_animtree["_encstr_B2FF07CB61C0A3BF5D"] = #animtree;
  level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = % _encstr_AAC71A5B07AFD2E6335A1BFA1B8927C29DB7D7857D76D597D8BEEEDA;
  level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = "_encstr_AAC71A5B07AFD2E6335A1BFA1B8927C29DB7D7857D76D597D8BEEEDA";
  level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A9020DB9EB43D7D81FA1D18A17F1C0"] = "_encstr_B4A811DC48B0E9BAD8A9E3AB9B74B26720F683";
  level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_99741258761D395D47D9C84323F0F4293D3382EB"] = % _encstr_B2A41FED4796DFEDBD20A2A9308DA2B7EBA05799483917F0F5793AD370C9D13760;
  level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_99741258761D395D47D9C84323F0F4293D3382EB"] = "_encstr_B2A41FED4796DFEDBD20A2A9308DA2B7EBA05799483917F0F5793AD370C9D13760";
  level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_99741258761D395D47D9C84323F0F4293D3382EB"] = "_encstr_966C161FC871A90277F94E42571D0A5739D9A7A318EB27EF";
  level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = % _encstr_AB711F07073E7B989082414739308A50CB82C781B17A173233B95438622041D818;
  level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = "_encstr_AB711F07073E7B989082414739308A50CB82C781B17A173233B95438622041D818";
  level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_A7C21261193E514B974920807023552E08825D52"] = "_encstr_BA7D16FBD52A9BC81F8B20B8A76EE0BFE231E1706DA32FBB";
  level.scr_anim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = % _encstr_86B42468DA9780F8B27F395743DA3E1856F5D6618917282BCFBF012FB723907078CC3B3E2B75;
  level.scr_animname["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = "_encstr_86B42468DA9780F8B27F395743DA3E1856F5D6618917282BCFBF012FB723907078CC3B3E2B75";
  level.scr_eventanim["_encstr_B2FF07CB61C0A3BF5D"]["_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95"] = "_encstr_97801BB4CDCCB463BEC6899316B3DBAF857D1BDBED1CFA2BF05AD1EBB1";
}

activate_extraction_flare() {
  if(istrue(self.bgivensentry)) {
    return;
  }
  if(istrue(self.tablet_out)) {
    return;
  }
  if(istrue(self.waiting_to_spawn)) {
    return;
  }
  if(self isskydiving()) {
    return;
  }
  if(istrue(self.spectating)) {
    return;
  }
  if(istrue(self.isreviving)) {
    return;
  }
  if(istrue(self.inlaststand)) {
    return;
  }
  if(!istrue(self.extraction_active)) {
    self iprintln("_encstr_B83D2A01077EA530A4431EEB23803FCE9712B5DF357B2869117017160190978299E8DC470218BF2843919BA3" + level.time_till_next_extraction + "_encstr_9A210C107999029AACB1BDCD469B");
    return;
  }

  if(isDefined(level.extraction_vehicle)) {
    self iprintln("_encstr_A5CB379573429F302393695E33E9A84660BF1DEBD7BAB1E9C6BF89028AF7CC50DA5BFBA5383AB0A32F293856ED7B9A4F5D58715E6903AF6DB2" + level.extraction_vehicle.origin);
    return;
  }

  level.extraction_uses++;
  level.extraction_in_progress = 1;

  foreach(var_1 in level.players)
  var_1 notify("_encstr_9A851BEB58186884B8179F9B33EADF0B437F7F354F715B32E2EBC85045", 0, self);

  level.extraction_in_progress = undefined;
}

get_extraction_cooldown() {
  level.extraction_cooldown = 30 + 10 * level.extraction_uses;
  return level.extraction_cooldown;
}

toggle_extraction_functionality_after_timeout(var_0, var_1) {
  level.extraction_in_progress = 1;
  self notify("_encstr_9A851BEB58186884B8179F9B33EADF0B437F7F354F715B32E2EBC85045", 0, var_1);
  level.time_till_next_extraction = level.extraction_cooldown;
  level thread time_till_next_extraction_tick();
  var_2 = gettime() + var_0 * 1000;

  for(var_3 = var_0; var_3 >= 0; var_3--)
    wait 1;

  self notify("_encstr_9A851BEB58186884B8179F9B33EADF0B437F7F354F715B32E2EBC85045", 1, var_1);
  level.extraction_in_progress = undefined;
}

turn_on_after_timeout(var_0, var_1) {
  level.time_till_next_extraction = level.extraction_cooldown;
  level thread time_till_next_extraction_tick();
  var_2 = gettime() + var_0 * 1000;

  for(var_3 = var_0; var_3 >= 0; var_3--)
    wait 1;

  self notify("_encstr_9A851BEB58186884B8179F9B33EADF0B437F7F354F715B32E2EBC85045", 1, var_1);
}

time_till_next_extraction_tick() {
  for(;;) {
    if(level.time_till_next_extraction <= 0) {
      break;
    }

    level.time_till_next_extraction--;
    wait 1;
  }
}

extraction_function_toggle() {
  self notify("_encstr_A60B1B3A6255BB2E6069E1FF4559376FF0B9A362E820572328A7E7F47B");
  self endon("_encstr_A60B1B3A6255BB2E6069E1FF4559376FF0B9A362E820572328A7E7F47B");

  for(;;) {
    self waittill("_encstr_9A851BEB58186884B8179F9B33EADF0B437F7F354F715B32E2EBC85045", var_0, var_1);

    if(istrue(var_0)) {
      if(!istrue(self.extraction_active)) {
        foreach(var_3 in level.players)
        var_3.extraction_active = 1;
      }

      continue;
    }

    if(self == var_1) {
      if(!isDefined(self.extractioninfo)) {
        var_5 = spawnStruct();
        var_5.owner = self;
        var_5.streakname = "_encstr_A3F80BB32063825899CB03DA0B";
        var_5.deployweaponobj = getcompleteweaponname("_encstr_A9AF1246CAC1367B2FAF0B969CC8C9DB07AFD683");
        self.extractioninfo = var_5;
      }

      var_6 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(self.extractioninfo, self.extractioninfo.deployweaponobj, "_encstr_9B620D8F0DC07577C551F16A3826BF", undefined, scripts\cp_mp\killstreaks\airdrop::airdropmarkerswitchended, ::airdropmarkerfired, undefined, scripts\cp_mp\killstreaks\airdrop::airdropmarkertaken);

      if(!istrue(var_6))
        continue;
    }

    level.extraction_uses++;
    level.extraction_in_progress = 1;
    level.extraction_in_progress = undefined;
    self iprintln("_encstr_BD322280543CA39316C6D1D2BDE6109155C9D045923DC940A7E4081A9EF49822D3D59380");

    foreach(var_3 in level.players)
    var_3 thread turn_on_after_timeout(get_extraction_cooldown(), var_1);
  }
}

airdropmarkerfired(var_0, var_1, var_2) {
  var_0.airdroptype = var_0.streakname;
  var_2.owner = self;
  var_2 thread airdropmarkeractivate(var_0.airdroptype);
  var_0.airdropmarkerfired = 1;
  return "_encstr_88E30897BDF1B71F7823";
}

airdropmarkeractivate(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_B805167E93CD6842D8B877CFC0300D53033E83F48413A39D");
  self endon("_encstr_B805167E93CD6842D8B877CFC0300D53033E83F48413A39D");
  var_2 = self.owner.angles;
  self waittill("_encstr_860808CB78E2984063BA", var_3);
  var_4 = self.owner;

  if(!isDefined(var_4)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

    return;
  }

  if(var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_8431130BB3EFE811D5E17870BAAED7858F4683F53C")]]()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

    return;
  }

  waitframe();
  weapondetonatedextraction(var_4.extractioninfo, var_3, var_4);
}

weapondetonatedextraction(var_0, var_1, var_2) {
  level.extraction_structs = scripts\engine\utility::get_array_of_closest(var_1, scripts\engine\utility::getStructArray("_encstr_956217D838EB8CBDE6AC479BB5AFD056D8B4BE371C58DD9BB9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), undefined, 1, 6669);
  var_3 = (var_1[0], var_1[1], 5000);

  if(level.script == "_encstr_ACFA0BB7B381457BEEDF03FB44") {
    if(level.extraction_structs.size > 0)
      var_3 = (level.extraction_structs[0].origin[0], level.extraction_structs[0].origin[1], 5000);
  }

  var_4 = (0, randomfloat(360), 0);
  var_5 = var_3 + -1 * anglesToForward(var_4) * 30000;
  var_3 = var_3 * (1, 1, 0);
  var_6 = var_3 + (0, 0, 5000);
  var_7 = 5000;
  level.extraction_vehicle = spawnlittlebird(0, var_2, var_5, var_6, var_2.extractioninfo, var_3);
  var_8 = vectortoangles(var_6 - var_5);
  level.extraction_vehicle.vehiclename = "_encstr_9A8F0CB1A5E8471BB2EB894B39C8";
  level.extraction_vehicle.speed = 50;
  level.extraction_vehicle.accel = 125;
  level.extraction_vehicle.isheli = 1;
  level.extraction_vehicle.vehicletype = "_encstr_88CD07337F8B2B8083";
  level.extraction_vehicle vehicle_setspeed(level.extraction_vehicle.speed, level.extraction_vehicle.accel);
  level.extraction_vehicle sethoverparams(50, 100, 50);
  level.extraction_vehicle setturningability(0.05);
  level.extraction_vehicle setotherent(var_2);
  level.extraction_vehicle.pathgoal = var_6;
  var_9 = randomint(10);
  var_10 = 10 + var_9;
  var_2 thread monitorarriveoverdestination(level.extraction_vehicle, var_1, "_encstr_9A8507BA4040188D08", var_10);
  level notify("_encstr_A233127B53F38EB0A3DBE03845B7E84FCAABE3F1");
}

spawnlittlebird(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = vectortoangles(var_3 - var_2);
  var_7 = 99;
  var_8 = 99999;
  var_9 = spawnhelicopter(var_1, var_2, var_6, "_encstr_BADC10304DDB593E1FE6C245DCE75BCF28E3", "_encstr_B85414BCDF02F19615D70899DF390B87EA86364F732A");

  if(!isDefined(var_9)) {
    return;
  }
  if(isDefined(var_5))
    var_9.lz = scripts\engine\utility::drop_to_ground(var_5) + (0, 0, 150);

  var_9.damagecallback = ::callback_vehicledamage;
  var_10 = 1;
  var_9.speed = 50;
  var_9.accel = 125;
  var_9.health = var_8;
  var_9.maxhealth = var_9.health;
  var_9.team = var_1.team;
  var_9.owner = var_1;
  var_9 setCanDamage(var_10);
  var_9.defendloc = var_3;
  var_9.lifeid = var_0;
  var_9.jackal = 1;
  var_9.streakinfo = var_4;
  var_9.streakname = var_4.streakname;
  var_9.streakinfo = var_4;
  var_9.flaresreservecount = var_7;
  var_9 setmaxpitchroll(0, 90);
  var_9 vehicle_setspeed(var_9.speed, var_9.accel);
  var_9 sethoverparams(50, 100, 50);
  var_9 setturningability(0.05);
  var_9 setyawspeed(45, 25, 25, 0.5);
  var_9 setotherent(var_1);
  var_9.exfilspace = level.players.size;
  var_11 = scripts\cp\cp_objectives::requestworldid("_encstr_B2A70AE543B1DF6DCF08926A", 10);
  objective_state(var_11, "_encstr_AF5A081BBAC993AC73A3");
  objective_position(var_11, var_9.lz + (0, 0, 20));
  objective_icon(var_11, "_encstr_8FEC166198B7CB394FEB2798CD97BAEB1110B0BC7237A031");
  objective_setminimapiconsize(var_11, "_encstr_8A9C0D3F5F2072CF1829A72BE0682A");
  objective_setshowdistance(var_11, 1);
  objective_setplayintro(var_11, 1);
  level thread show_exfil_progress(var_11, var_2, var_3, var_9);
  var_9 thread scripts\cp\infilexfil\blima_exfil::keep_from_crushing_players();
  var_9.objnum = var_11;
  scripts\cp\infilexfil\blima_exfil::spawn_vehicle_actors(var_9);
  var_9.occupancy = [];
  var_9.passengers[0] = self;
  var_9.passengers[1] = self;
  var_9.passengers[2] = self;
  var_9.passengers[3] = self;
  var_9.passengers[4] = self;
  var_9.passengers[5] = self;
  var_9 init_useprompt_interactions();
  level.extraction_vehicles[level.extraction_vehicles.size] = var_9;
  level.extraction_vehicles = scripts\engine\utility::array_removeundefined(level.extraction_vehicles);
  var_9 thread scripts\cp\cp_flares::flares_handleincomingstinger(undefined, undefined);
  var_9 thread littlebirddestroyed();
  return var_9;
}

show_exfil_progress(var_0, var_1, var_2, var_3) {
  var_3 endon("_encstr_AD75063D571AE108");
  var_3 endon("_encstr_8B7205D9ED5958");
  level endon("_encstr_91AA10A4C71A4BF9FC1F7958E71B319BA22B");
  objective_setlabel(var_0, &"_encstr_AB7F2490AF08A33A491F999A472135FBDAA52869146477A2F22BE0967B61C92F703F60E15F55");
  objective_setshowprogress(var_0, 1);
  objective_setprogress(var_0, 0);
  objective_setbackground(var_0, 1);
  var_4 = distance(var_1, var_2) / 50;

  for(;;) {
    wait 1;
    var_5 = distance(var_3.origin, var_2) / 50;
    objective_setprogress(var_0, var_5 / var_4);

    if(var_5 <= 0)
      return;
  }
}

init_useprompt_interactions(var_0) {
  self.interactiontriggers = [];
  var_1 = self gettagorigin("_encstr_A3CC0FEB30D11F438BF68A0750BF2AFAB3");
  var_2 = self gettagorigin("_encstr_93CC0FF179CFE9378F3393590A7F655832");
  var_3 = self gettagorigin("_encstr_A1CC0F1DC2767D0EB06E9BB273ECB23933");
  var_4 = self gettagorigin("_encstr_8ECC0F13404778BB59873F951D37C95581");
  var_5 = self gettagorigin("_encstr_B8CC0FF3835F1FE72EDBB741322F8DFB7F");
  var_6 = self gettagorigin("_encstr_ACCC0FA30B76AF0E58B96E56E63B2BC96C");
  create_exfil_interaction(var_2, &"_encstr_818B1AA641E521F48911F5A2A7F58EA8A8AFE993FA0D429E2805A249", 2, var_0);
  create_exfil_interaction(var_3, &"_encstr_818B1AA641E521F48911F5A2A7F58EA8A8AFE993FA0D429E2805A249", 4, var_0);
  create_exfil_interaction(var_5, &"_encstr_818B1AA641E521F48911F5A2A7F58EA8A8AFE993FA0D429E2805A249", 3, var_0);
  create_exfil_interaction(var_6, &"_encstr_818B1AA641E521F48911F5A2A7F58EA8A8AFE993FA0D429E2805A249", 5, var_0);
}

create_exfil_interaction(var_0, var_1, var_2, var_3) {
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_4 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_4 linkTo(self);
  var_4 setHintString(var_1);
  var_4 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_4 sethintdisplayrange(200);
  var_4 sethintdisplayfov(90);
  var_4 setuserange(72);
  var_4 setusefov(90);
  var_4 sethintonobstruction("_encstr_BECC055CF3811A");
  var_4 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_4 thread exfil_use_think(self, var_2, var_3);
  self.interactiontriggers[self.interactiontriggers.size] = var_4;
}

exfil_use_think(var_0, var_1, var_2) {
  if(isDefined(var_2))
    makechopperseatplayerusable(var_2);
  else
    makechopperseatteamusable(var_0.team);

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_3);
    self makeunusable();
    var_0 exfilusetriggerused(var_3, var_1, self);
  }
}

makechopperseatteamusable(var_0) {
  self makeusable();
  thread _updatechopperseatteamusable(var_0);
}

makechopperseatplayerusable(var_0) {
  self makeusable();
  thread _updatechopperseatplayerusable(var_0);
}

_updatechopperseatteamusable(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2.team == var_0) {
        self showtoplayer(var_2);
        self enableplayeruse(var_2);
        continue;
      }

      self disableplayeruse(var_2);
      self hidefromplayer(var_2);
    }

    level waittill("_encstr_81170C244F9CBDE72C01BB99A298");
  }
}

_updatechopperseatplayerusable(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2 == var_0) {
        self showtoplayer(var_2);
        self enableplayeruse(var_2);
        continue;
      }

      self disableplayeruse(var_2);
      self hidefromplayer(var_2);
    }

    level waittill("_encstr_81170C244F9CBDE72C01BB99A298");
  }
}

exfilusetriggerused(var_0, var_1, var_2) {
  if(!isDefined(self.exfilspace))
    self.exfilspace = level.players.size;

  if(self.exfilspace > 0) {
    var_0 thread playeranimlinktochopper(self, var_1);
    self.occupancy = scripts\engine\utility::array_add(self.occupancy, var_0);
    var_2.occupied = var_0;

    foreach(var_4 in self.interactiontriggers) {
      if(var_4 != var_2)
        var_4 thread makechopperseatteamusable(self.team);
    }

    thread disableotherseats(var_0, var_1, var_2);
    self.exfilspace--;

    if(self.exfilspace <= 0) {
      self notify("_encstr_BE6B0C95B3969848376C615888B0");
      return;
    }
  } else
    self notify("_encstr_BE6B0C95B3969848376C615888B0");
}

disableotherseats(var_0, var_1, var_2) {
  foreach(var_4 in self.interactiontriggers)
  var_4 disableplayeruse(var_0);

  if(isDefined(var_2))
    var_0 thread enableexitprompt(var_1, self, var_2);
}

enableexitprompt(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3 linkTo(self);
  var_3 setHintString(&"_encstr_8DA71BA6059742F49844AFA83DBEA3A88ABEE99191F50D24E941051525");
  var_3 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_3 sethintdisplayrange(200);
  var_3 sethintdisplayfov(90);
  var_3 setuserange(200);
  var_3 setusefov(360);
  var_3 sethintonobstruction("_encstr_BECC055CF3811A");
  var_3 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_3 thread exfil_hopoff_think(var_1, self, var_0, var_2);
  var_1.exitinteract = var_3;
}

exfil_hopoff_think(var_0, var_1, var_2, var_3) {
  makechopperseatplayerusable(var_1);

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
    self makeunusable();
    var_1 lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
    var_0.exfilspace++;
    var_1 stopanimscriptsceneevent();
    var_0 scripts\cp\cp_anim::anim_player_solo(var_1, var_1.player_rig, "_encstr_B8341763FA639ABB28A9ED1B9E686210B89F1DD31FD230EB95", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
    var_1.player_rig unlink();
    var_1 unlink();
    var_3 makechopperseatteamusable(var_0.team);
    var_0.occupancy = scripts\engine\utility::array_remove(var_0.occupancy, var_1);
    var_3.occupied = undefined;

    foreach(var_5 in level.players) {
      if(scripts\engine\utility::array_contains(var_0.occupancy, var_5)) {
        var_3 hidefromplayer(var_5);
        var_3 disableplayeruse(var_5);
      }
    }

    foreach(var_8 in var_0.interactiontriggers) {
      if(!isDefined(var_8.occupied)) {
        var_8 showtoplayer(var_1);
        var_8 enableplayeruse(var_1);
        continue;
      }

      var_8 hidefromplayer(var_8.occupied);
      var_8 disableplayeruse(var_8.occupied);
    }

    var_1 notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
    var_1.player_rig delete();
    var_0 notify("_encstr_BD82096B5DA4B07F924F29");
    self delete();
  }
}

playerlinktochopper(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0.extracted = 1;
  var_0.spawnprotection = 1;

  while(!var_0 isonground())
    waitframe();

  var_0 allowmovement(0);
  var_0 playerlinkTo(var_1, "_encstr_96F20EADF9077641FE9B2890221713AB" + var_2, 1.0, 180, -180, 180, 180, 0);
}

playeranimlinktochopper(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");

  if(!isDefined(var_1)) {
    for(var_2 = 0; var_2 < var_0.passengers.size; var_2++) {
      if(var_0.passengers[var_2] == var_0.extractzone) {
        var_0.passengers[var_2] = self;
        var_1 = var_2;
      }
    }

    var_0 thread disableotherseats(self);
  }

  thread extraction_infil_player_rig("_encstr_AC6B06F0DA2281E1" + var_1, "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A");
  self.player_rig linkTo(var_0, "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1", (0, 0, 0), (0, 0, 0));

  switch (var_1) {
    case 0:
      self lerpviewangleclamp(1, 0.25, 0.25, 35, 180, 90, 45);
      break;
    case 1:
      self lerpviewangleclamp(1, 0.25, 0.25, 180, 35, 90, 45);
      break;
    case 4:
    case 2:
      self lerpviewangleclamp(1, 0.25, 0.25, 75, 135, 90, 45);
      break;
    case 5:
    case 3:
      self lerpviewangleclamp(1, 0.25, 0.25, 135, 45, 90, 45);
      break;
    default:
      self lerpviewangleclamp(1, 0.25, 0.25, 45, 45, 45, 45);
      break;
  }

  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.extracted = 1;
  rideloop(var_0);
}

#using_animtree("_encstr_B40101");

extraction_infil_player_rig(var_0, var_1, var_2) {
  self.animname = var_0;
  self predictstreampos(self.origin);
  var_3 = spawn("_encstr_BEFE0C2FAB5A88876B4181EB4A5F", self.origin, 0, 0, self);
  var_3.angles = self.angles;
  var_3.player = self;
  self.player_rig = var_3;
  self.player_rig hide(1);
  self.player_rig.animname = var_0;
  self.player_rig useanimtree(#animtree);
  self.player_rig.updatedversion = 1;
  self.player_rig.cinematic_motion_override = scripts\mp\utility\infilexfil::handlecinematicmotionnotetrack;
  self playerlinktodelta(self.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1.0, 0, 0, 0, 0, 1);

  if(isDefined(var_2) && var_2)
    self playersetgroundreferenceent(self.player_rig);

  self notify("_encstr_A9920CF579D7F1B6CBAAD963B24B");
  scripts\engine\utility::_id_143A5("_encstr_BE840BF2FFD8B0A4DB6EE31FA1", "_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");

  if(isDefined(var_2) && var_2)
    self playersetgroundreferenceent(undefined);

  if(isDefined(self))
    self unlink();

  if(isDefined(var_3))
    var_3 delete();
}

rideloop(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9B5711E036B097599C7D99C9CAB2F56E1C7B3A");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  var_0 endon("_encstr_81A8077D3088BFA631");
  var_0 endon("_encstr_BD82096B5DA4B07F924F29");

  while(isDefined(var_0))
    var_0 scripts\cp\cp_anim::anim_player_solo(self, self.player_rig, "_encstr_A7C21261193E514B974920807023552E08825D52", "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
}

register_extraction_interactions() {
  scripts\cp\cp_interaction::registerinteraction("_encstr_A3F80BB32063825899CB03DA0B", ::hint_extraction, ::activate_extraction, ::init_extraction, 0, "_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9");
}

init_extraction(var_0) {
  if(var_0.size > 0) {
    foreach(var_2 in var_0) {}
  }
}

hint_extraction(var_0, var_1) {
  return &"_encstr_B40101";
}

activate_extraction(var_0, var_1) {}

delayjackalloopsfx(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self playLoopSound(var_1);
}

littlebirddestroyed() {
  self endon("_encstr_BD9A0C532CD8D6161BEBB3DBB9B2");
  var_0 = self.owner;
  self waittill("_encstr_AD75063D571AE108");

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.largeprojectiledamage)) {
    self vehicle_setspeed(25, 5);
    thread littlebirdcrash(75);
    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  if(isDefined(self.lz))
    self.lz notify("_encstr_963715B53B8DFAA769EBAB5ADEDFB1BD8B535BF0DABFA8");

  littlebirdexplode();
}

littlebirdexplode() {
  self playSound("_encstr_9B501454D5482AF70B684BA1F15BB365F051CDE71358");
  level.extraction_vehicles[level.extraction_vehicles.size - 1] = undefined;
  self notify("_encstr_860808CB78E2984063BA");
  wait 0.35;
  thread littlebirddelete();
}

littlebirddelete() {
  if(isDefined(self.turret))
    self.turret delete();

  if(isDefined(self.cannon))
    self.cannon delete();

  if(isDefined(self.useobj))
    self.useobj delete();

  foreach(var_1 in self.interactiontriggers)
  var_1 delete();

  self delete();
}

littlebirdcrash(var_0) {
  self endon("_encstr_860808CB78E2984063BA");
  self clearlookatent();
  self notify("_encstr_834F10F2726A6339BCFF3243DB681CD46B4C");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
  self settargetyaw(self.angles[1] + var_0 * 2.5);
}

callback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner))
      var_1 = var_1.owner;
  }

  if((var_1 == self || isDefined(var_1.pers) && var_1.pers["_encstr_8AEF05472BC2D6"] == self.team && !level.friendlyfire && level.teambased) && var_1 != self.owner) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  if(self.health <= var_2) {
    if(isPlayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner)) {}
  }

  if(self.health - var_2 <= 900 && (!isDefined(self.smoking) || !self.smoking))
    self.smoking = 1;

  self vehicle_finishdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

monitorarriveoverdestination(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BA2D081B2B58B32D37EC");
  var_0 setvehgoalpos(var_0.pathgoal, 1);
  var_0 thread changemaxpitchrollwhenclosetogoal(var_0.pathgoal);
  var_0 waittill("_encstr_8B7205D9ED5958");
  level notify("_encstr_91AA10A4C71A4BF9FC1F7958E71B319BA22B");

  if(isDefined(var_0.objnum))
    objective_delete(var_0.objnum);

  var_0 thread watchgameendleave();

  if(isDefined(var_3)) {
    var_4 = var_0.speed;
    var_5 = var_0.accel;
  } else {
    var_4 = var_0.speed / 4;
    var_5 = var_0.accel / 6;
  }

  var_0 vehicle_setspeed(var_4, var_5);
  var_0 littlebirddescendtoextraction(var_1, var_0.zone, var_2);
}

littlebirdleave() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = self.speed;
  var_1 = self.accel;
  self setmaxpitchroll(0, 0);
  self notify("_encstr_BA2D081B2B58B32D37EC");
  self.leaving = 1;
  self clearlookatent();
  var_2 = int(self.speed / 14);
  var_3 = int(self.accel / 16);

  if(isDefined(var_0))
    var_2 = var_0;

  if(isDefined(var_1))
    var_3 = var_1;

  self vehicle_setspeed(var_2, var_3);
  var_4 = self.origin + (0, 0, 5000);
  self setvehgoalpos(var_4, 1);

  if(isDefined(self.useobj))
    self.useobj delete();

  self waittill("_encstr_8B7205D9ED5958");
  var_4 = self.origin + anglesToForward((0, randomint(360), 0)) * 5000;
  var_4 = var_4 + (0, 0, 1000);
  self setvehgoalpos(var_4, 1);

  if(isDefined(self.useobj))
    self.useobj delete();

  self waittill("_encstr_8B7205D9ED5958");
  var_5 = getpathend();
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(var_5, 1);
  self waittill("_encstr_8B7205D9ED5958");
  self stoploopsound();
  level.extraction_vehicles[level.extraction_vehicles.size - 1] = undefined;
  self notify("_encstr_BD9A0C532CD8D6161BEBB3DBB9B2");

  if(self.occupancy.size == level.players.size)
    level thread[[level.endgame]]("_encstr_9A8507BA4040188D08", level.end_game_string_index["_encstr_91190447C232"]);
  else {
    foreach(var_7 in self.occupancy) {
      var_7 iprintln("_encstr_AB8F1D46ADE77F1F52C7362DD57A55CB3DE7BE38174D4B1E51ED1D22CBAAB6");
      kick(var_7 getentitynumber(), "_encstr_A6CC1AB8383F0A01305921294D57CBBB789D75196328214621BF17D3", 1);
    }
  }

  littlebirddelete();
}

getpathend() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

littlebirddescendtoextraction(var_0, var_1, var_2) {
  descend(var_0, var_1);
  scripts\engine\utility::_id_143B9(60, "_encstr_8D5609DA3DA4A282035BED");
  thread littlebirdleave();
}

descend(var_0, var_1) {
  self endon("_encstr_BAFC0789BA3BD35DA3");
  var_2 = undefined;
  var_3 = var_0[0];
  var_4 = var_0[1];
  var_5 = tracegroundheight(var_3, var_4, 0);
  var_2 = (var_3, var_4, var_5);
  var_2 = self.lz;
  self clearlookatent();
  self setvehgoalpos(var_2, 1);
  self waittill("_encstr_8B7205D9ED5958");
  self sethoverparams(0, 0, 0);
  self vehicle_setspeedimmediate(0);
}

tracegroundheight(var_0, var_1, var_2, var_3) {
  var_4 = 30;
  var_5 = tracegroundpoint(var_0, var_1, var_3);
  var_6 = var_5 + var_4;
  return var_6;
}

tracegroundpoint(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A56910C7FEFF7B196E3B10F8638EF09C1B24");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_3 = -99999;
  var_4 = self.origin[2] + 2000;
  var_5 = level.averagealliesz;
  var_6 = [self];

  if(isDefined(self.dropcrates)) {
    foreach(var_8 in self.dropcrates)
    var_6[var_6.size] = var_8;
  }

  var_10 = 256;

  if(isDefined(var_2))
    var_11 = scripts\engine\trace::ray_trace((var_0, var_1, var_4), (var_0, var_1, var_3), var_6, undefined, undefined, 1);
  else
    var_11 = scripts\engine\trace::sphere_trace((var_0, var_1, var_4), (var_0, var_1, var_3), 256, var_6, undefined, 1);

  if(var_11["_encstr_BD260953AA97E3F014279D"][2] < var_5)
    var_12 = var_5;
  else
    var_12 = var_11["_encstr_BD260953AA97E3F014279D"][2];

  return var_12;
}

watchgameendleave() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread littlebirdleave();
}

changemaxpitchrollwhenclosetogoal(var_0) {
  self endon("_encstr_8B7205D9ED5958");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");

  for(;;) {
    if(distance2d(self.origin, var_0) < 768) {
      self setmaxpitchroll(10, 25);
      break;
    }

    wait 0.05;
  }
}

abortextractpickup() {
  thread littlebirdleave();
}
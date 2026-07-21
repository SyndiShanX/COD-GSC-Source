/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\init_cp_mp.gsc
***********************************************/

init() {
  setDvar("_encstr_BEF80B3DEB91A709E3A5D7AF1D", 1);
  setDvar("_encstr_AB840B539C2A6905C9C43D2815", 1);

  if(!isDefined(level.players))
    level.players = [];

  anim_init();
  hud_init();
  killstreak_init();
  equipment_init();
  player_init();
  vehicle_init();
  game_init();
  emp_init();
  tripwire_init();
  weapons_init();
  damage_init();
  entity_init();
  sound_init();
  flares_init();
  shellshock_init();
  outline_init();
  game_utility_init();
  rank_init();
  _id_14599();
  supers_init();
  gamescore_init();
}

anim_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B68305BA601B07", "_encstr_91360C90E16F51DD2379A28FE580", scripts\cp\cp_anim::anim_player_solo);
}

hud_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF", scripts\cp\cp_hud_message::showerrormessage);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18", scripts\cp\cp_hud_util::teamplayercardsplash);
}

killstreak_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C5055208731B", scripts\cp\killstreaks\init_cp::init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23", scripts\cp\utility::addtoactivekillstreaklist);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_AD181328DA434039D2D7C9CDA72AF2E90536736005", scripts\cp\utility::iskillstreakweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_99CC1EFA6008DF6BF748AF2BD457D995CE05C3E9AA98AB22E88B217B088B128B", scripts\cp\utility::allowridekillstreakplayerexit);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_B86B122720C9FFAA9C813F4CB0CF03D14F83D0DB", scripts\cp\cp_mapselect::getselectmappoint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_933717DC8E0B93A39AB007A9561B596C8EA62BB8BAAC733656", scripts\cp\cp_mapselect::startmapselectsequence);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A76B16AD2D1B366EE8279558AD6A586D2B65B24396368D2B", scripts\cp\utility::killstreak_make_vehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BA2C22DA4B1B636E3A4EACB05BA959D1824EAC35DE3211C2ADC2ECB2A1161BD83116D8AD", scripts\cp\utility::killstreak_set_pre_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B8E23648C086413B108EF30B3A2C961BF8722F3617FE2ECDF5B3AC730C7790D109589A9B8", scripts\cp\utility::killstreak_set_post_mod_damage_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C31B72E8F17B12703D858927615FC33D812A0B50CE078DC805B993DF", scripts\cp\utility::killstreak_set_death_callback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B2D0E10DA55893B8B12D5DF13A3A071", scripts\cp\utility::killstreakhit);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_9A64178616904FE92BF070CFF4A7C0BA98AA78695339A7A4CE", scripts\cp\crafting_system::support_box_spawn);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A1F220D92BD1D4BD462D99B4B2910AE63A96D296D81BCDD1E42B16B58858B516ECB2", scripts\cp\cp_damage::getmodifiedantikillstreakdamage);
}

equipment_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8DB70F93D8EE6703A83597A7D7784CBB9D", "_encstr_88C5055208731B", scripts\cp\equipment\throwing_knife_cp::throwing_knife_cp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_B2231AB32BD18AB85D2D07DAB29BE8252BCC194EBDB5752B16E0DEE6", scripts\cp\cp_equipment::getequipmentreffromweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AFD81716A3470BD8D0B556B9A329B99A958D2B36A316988DAC", scripts\cp\cp_weapon::carriedpunchcard);
}

player_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_ACBD09DFCB137F6DA3D832", scripts\cp\utility\player_utility_cp::_isalive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_979D0FE291986D039BF5BF53DBB10A84C8", scripts\cp\utility\player::setusingremote);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B864110E58F8B1EB6D271F0B67B6C2E57BE307", scripts\cp\utility\player::clearusingremote);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_A1750E827BBDD74450E7625D9B304BF7", scripts\cp\utility::isusingremote);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B2680F276E71EB3A2703FFBBA1636F5123", scripts\cp\utility::_freezecontrols);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC", scripts\cp\utility::printgameaction);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8C140CAFEF2FC261305972B65549", scripts\cp\utility::isplayerads);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B807125285B0A9B80472F441202DC7F76301A797", scripts\cp\utility::setthirdpersondof);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_9AE10CA1DBF963911A20E839FB60", scripts\cp\utility\player::hideminimap);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8FD40CAAA82AAF81A033D9C40B43", scripts\cp\utility\player::showminimap);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AAC0133C589B026BE92A5D0A9BF4B6AA4FC4B48B53", scripts\cp\utility::getplayersinradius);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_A22E0BD29BC8274BAC73238DCB", scripts\cp\utility\player::isfriendly);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56", scripts\cp\utility\player::isreallyalive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AD3610BA61F59FCBD03D8B957F2895CB957B", scripts\cp\utility\player::getstancecenter);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_93E50D674D73B7EB3398D28A7117A2", scripts\cp\utility\player::round_smoke_logic);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8ACE16618DA287E3384F90A0E345D8E108F26DF6E6EB47CB", scripts\cp\survival\survival_loadout::lookupcurrentoperator);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_958014B1BDDE6DEAC1A7E8D056E43DE02B2785E8DEC9", scripts\cp\survival\survival_loadout::lookupotheroperator);
}

vehicle_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_88C5055208731B", scripts\cp\vehicles\vehicle_cp::vehicle_cp_init);
}

host_migration_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_96940E34BDCDA3B55AEC9C583A5ABDDC", "_encstr_88A41A9B8FFFDC1DBA88B1854B25CAC3F89F353FB4339A1B7FFF7BB8", scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_96940E34BDCDA3B55AEC9C583A5ABDDC", "_encstr_B1BA1DD3A7AAFBAB631250B01F2BE054F88496E1DF9A5D3833CD7799A32E27", scripts\cp\cp_hostmigration::waittill_notify_or_timeout_hostmigration_pause);
}

game_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_8431130BB3EFE811D5E17870BAAED7858F4683F53C", scripts\cp\utility::isairdenied);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_B4050ECEB23AA8CD95B55EA8ACC2B5DC", scripts\cp\utility::getenemyteams);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB", scripts\cp\utility::getgametype);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_A15C0D845DEBD4A95C1AC0F93236A3", scripts\cp\utility::getotherteam);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_8171181E82557B0575B7C210B55711AA646DBD6DA409557F7DF3", scripts\cp\utility::vo_ten_remain);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841", scripts\cp\utility::killstreak_createobjective);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_B6481343D019E0F217299F763213BEF3CF6B375057", scripts\cp\utility::nonobjective_requestobjectiveid);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924", scripts\cp\utility::nonobjective_returnobjectiveid);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_85881311AA2BD460B48D3D11BC9839992703293B53", scripts\cp\cp_player_battlechatter::getfriendlyplayers);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_8492109210F704EBD8E63C3285018F47D5D8", scripts\mp\ammorestock::_id_1204A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_A18C12DEE6325A59B18C550EB393B032598ACDC8", scripts\mp\ammorestock::_id_12033);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361", scripts\cp\cp_player_battlechatter::trysaylocalsound);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_91A30E39A5D3B0FE67AA38A7833FB820", scripts\cp\cp_hud_message::tutorialprint);
}

emp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8B1804DF2043", "_encstr_88C5055208731B", scripts\cp\emp_debuff_cp::emp_debuff_init);
}

tripwire_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8DC1092BD38BC10B7CC337", "_encstr_88C5055208731B", scripts\cp\tripwire_cp::init);
}

entity_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_850E077B0BF30318B9", "_encstr_9B560FC8B236165E51B9D111CA36568E59", scripts\cp\utility::delayentdelete);
}

weapons_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_88CE0F4F718B3D408FE0B45E0DBAC6E9BB", scripts\cp\utility::_launchgrenade);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_880612DC365BD70912CF58E8D76C63F362DF45DE", scripts\cp\equipment\cp_gas_grenade::gas_createtrigger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_965B19CE563A22CA9958BA36D15D5685387B9B09C29B59930BB695", scripts\cp\utility::relic_nuketimer_globalthread);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AA501282FAD89F4D8863A73A7B97D251D9B60568", scripts\cp\utility::getweaponrootname);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_97F718A5B9680A1AA093D26B85395EF49CD456B1DB37230B39F2", scripts\cp\cp_weapon::iscacprimaryorsecondary);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AB7915491DABA7C6C9785AE2586BBE1B2685DFE23F13FF", scripts\cp\utility::attachmentmap_tobase);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_AFD81716A3470BD8D0B556B9A329B99A958D2B36A316988DAC", scripts\cp\cp_weapon::carriedpunchcard);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_B2201A392BB5C238508E47C2B11ADA56738E412CC995E6A3E4C2DA56", scripts\cp\cp_weapon::_id_12BBB);
}

damage_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA", scripts\cp\cp_damagefeedback::updatedamagefeedback);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_8CED1307B60498F97BF333FBFA2722D1241CB99B24", scripts\cp\utility::onkillstreakkilled);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_87FE0CE0F3BF3BC10FD6957BA04F", scripts\cp\cp_damagefeedback::hudicontype);
}

sound_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8260069BDBBACD46", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361", scripts\cp\cp_player_battlechatter::trysaylocalsound);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9", scripts\cp\cp_player_battlechatter::_id_1274C);
}

flares_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_A6DE168658DC32B156A4E68DDEDA2DB9D9D4D1A5E6CE59E4", scripts\cp\cp_flares::flares_handleincomingstinger);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_8B670FAEBFBD03705FE9ADCEC95BBE3BA6", scripts\cp\cp_flares::flares_reducereserves);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_AD830746560EB17BCB", scripts\cp\cp_flares::flares_deploy);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_91B007FA68E899B8EB", scripts\cp\cp_flares::flares_playfx);
}

shellshock_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_AB4D1537203BD17A197552887023E27283586FEF403015", scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_AFDA186663169B1A92B94795934EBA83D1882BC60B9791AECDC6", scripts\cp_mp\utility\shellshock_utility::shellshock_nointerruptdelayfunc);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_83631D97EFB2E6F013BA4098E5C1E0A5FA732D332BBB2D0854164AB5CBDED0", scripts\cp_mp\utility\shellshock_utility::shellshock_nointerruptdelayfunc);
}

bots_init() {}

outline_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA", scripts\cp\cp_outline_utility::outlinedisable);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_974217BDCBC00CCA609B5FFBFB1EE27D391072CA40B0D1C246", scripts\cp\cp_outline_utility::outlineenableforplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_ABFE150D7B70BC5AF00BAF0B6BAE52ED4980C25B912075", scripts\cp\cp_outline_utility::outlineenableforteam);
}

game_utility_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_88220D9C76FAE3CE55CB5868A78CC2", "_encstr_88C5055208731B", scripts\cp\utility\game_utility_cp::game_utility_cp_init);
}

rank_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A51F05CB11A052", "_encstr_B1CA125C95239F3F25232059FABFEFF7CF34DDC5", scripts\cp\drone\emp_drone::getscoreinfovalue);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A51F05CB11A052", "_encstr_8FFA0BE730B3E5A14BB84C888F", scripts\cp\drone\emp_drone::giverankxp);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A51F05CB11A052", "_encstr_8F1A19CF152BEBC645C80981119B7D8B60075C49BDB3BB0D29A052", scripts\cp\drone\emp_drone::getrankxpmultipliertotal);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A51F05CB11A052", "_encstr_ACA81EE76F689B61FB01B0CB7A69034FE96755602BCB08B1F14D5AE10AC59389", scripts\cp\drone\emp_drone::registerpublicevent);
}

_id_14599() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_911E0B43B819331743309A1E4A", "_encstr_95391FA11885072B29019F807A21E098B66F7D85507B8229289BCB1DE11823AFD0", scripts\cp\cp_weaponrank::getweaponrankxpmultipliertotal);
}

supers_init() {}

gamescore_init() {}
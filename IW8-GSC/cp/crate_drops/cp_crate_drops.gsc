/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\crate_drops\cp_crate_drops.gsc
***********************************************/

main() {
  if(!scripts\engine\utility::flag_exist("_encstr_920B1C7337E6879AC358A219C03D1503DB08FBFBD809EF65C970AAA3E079"))
    scripts\engine\utility::flag_init("_encstr_920B1C7337E6879AC358A219C03D1503DB08FBFBD809EF65C970AAA3E079");

  scripts\engine\utility::flag_wait("_encstr_920B1C7337E6879AC358A219C03D1503DB08FBFBD809EF65C970AAA3E079");
  level thread start_crate_drops();
}

start_crate_drops() {
  level.crate_drop_time = 15;
  level.crates_active_at_location = [];
  var_0 = "_encstr_B40101";
  var_1 = undefined;

  for(;;) {
    if(getdvarint("_encstr_BD4D1B9BC196CF6E2803BCB567C072473F7BD143686DCBA9307BADBD15", 0) != 0)
      level scripts\engine\utility::_id_143BA(level.crate_drop_time, "_encstr_ACB91543C3A812EC493B9F736A181458DB179CFE6883B3", "_encstr_9AAB0FC84EF6077D9356E25DB2E68E2B32");
    else
      level waittill("_encstr_9AAB0FC84EF6077D9356E25DB2E68E2B32", var_0, var_1);

    if(getdvarint("_encstr_8B76165BEE4AC107529FB7931F5A4E88E4C74631528F70BE", 0) == 0) {
      var_2 = getrandompointincpmap(var_0);

      if(!isDefined(var_2)) {
        continue;
      }
      if(isDefined(var_2.script_linkname)) {
        if(isDefined(level.crates_active_at_location[var_2.script_linkname]))
          continue;
      } else if(isDefined(var_2.script_noteworthy)) {
        if(isDefined(level.crates_active_at_location[var_2.script_noteworthy]))
          continue;
      }

      level thread dropcarepackage(var_2, var_1);
    }
  }
}

_id_12C40(var_0, var_1) {
  level notify("_encstr_9AAB0FC84EF6077D9356E25DB2E68E2B32", var_0, var_1);
}

getrandompointincpmap(var_0) {
  if(var_0 != "_encstr_B40101")
    return scripts\engine\utility::getStructArray(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B")[0];
  else {
    var_1 = scripts\cp\respawn\cp_ac130_respawn::getaverageorigin(level.players);
    var_2 = scripts\engine\utility::getStructArray("_encstr_A5FE0C81AB475B8AE123DB5F7B4A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_3 = scripts\engine\utility::get_array_of_closest(var_1, var_2, undefined, 1, 6669);

    if(var_3.size > 0)
      return var_3[0];
    else {
      var_3 = var_2[0];
      return var_3;
    }
  }
}

dropcarepackage(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = scripts\engine\utility::drop_to_ground(var_0.origin, 50, -200, (0, 0, 1));
  var_3 = var_3 + (0, 0, 1);

  if(!istrue(level.announcer_vo_playing) && !istrue(level.validatealivecount))
    thread scripts\cp\cp_dialogue::play_vo_to_all("_encstr_BE9821E9C3D191A851E173EB533499DFEA43514D07CB70C07A4499807FEC5018833FDB", 6);

  var_4 = mlgiconemptyflag(var_3, var_2);

  if(isDefined(var_1))
    var_4._id_129F9 = var_1;

  var_4 thread oncratedrop(var_3, var_0);

  if(isDefined(var_0.script_linkname))
    level.crates_active_at_location[var_0.script_linkname] = var_4;
  else if(isDefined(var_0.script_noteworthy))
    level.crates_active_at_location[var_0.script_noteworthy] = var_4;

  return var_4;
}

mlgiconemptyflag(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "_encstr_AC20072B9FA9487832", scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "_encstr_B19A0BD803A4E10F42E50598BB", "_encstr_978D09FA80F57CF330A07E"));
  var_3 = "_encstr_8C2911AA53EDAB3EC8A317EE3788022F8D69E3";

  if(getDvar("_encstr_962714AF888B89C873D10DB2DFCBE9611F0239ABB573", "_encstr_B40101") != "_encstr_B40101")
    var_3 = getDvar("_encstr_962714AF888B89C873D10DB2DFCBE9611F0239ABB573", "_encstr_B40101");

  if(isDefined(var_1))
    var_3 = var_1;

  var_4 = mlghitlocrequiresclamp(undefined, "_encstr_9A8507BA4040188D08", var_3, var_0, (0, randomfloat(360), 0), var_0, scripts\cp\killstreaks\airdrop_cp::getcpcratedatabytype(var_3));

  if(!isDefined(var_4))
    return undefined;
  else if(!isDefined(var_4.crate))
    return undefined;

  return var_4.crate;
}

oncratedrop(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_2 setModel("_encstr_A5341932F00DA43F789DF7D721661FEAA3285A7A2BA7DA473072D5");
  var_2.angles = (0, 90, 90);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_3 setModel("_encstr_B231139B17092E334F8B5AE1B097FBE460BD371569");
  var_3 setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_AB0703DBB9", 0);
  var_2 thread watchforcratecapture(self);
  var_3 thread watchforcratecapture(self);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(90);

  if(isDefined(var_1.script_noteworthy)) {
    if(isDefined(level.crates_active_at_location[var_1.script_noteworthy]))
      level.crates_active_at_location[var_1.script_noteworthy] thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }

  if(isDefined(var_1.script_linkname)) {
    if(isDefined(level.crates_active_at_location[var_1.script_linkname]))
      level.crates_active_at_location[var_1.script_linkname] thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }
}

watchforcratecapture(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_AD75063D571AE108");
  self delete();
}

relic_healthpacks_wait_for_pickup(var_0, var_1) {
  var_2 = undefined;

  if(istrue(var_1))
    var_2 = var_0 * (1, 1, 0) + (0, 0, relic_landlocked_clear_message_on_player_return());
  else
    var_2 = var_0 + (0, 0, 25);

  return var_2;
}

relic_landlocked_clear_message_on_player_return() {
  return 3000 + level.cratedropdata.helis.size * level.cratedropdata.heliheightoffset;
}

mlghitlocrequiresclamp(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BE381A6CAB27392BCD1DA036A396CEACAC2B0DA5B11B5968F657CDD1") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BE381A6CAB27392BCD1DA036A396CEACAC2B0DA5B11B5968F657CDD1")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")]]())
      return undefined;
  }

  var_8 = relic_healthpacks_wait_for_pickup(var_3, 1);
  var_9 = var_4 * (0, 1, 0);

  if(!isDefined(var_5)) {
    var_5 = scripts\cp_mp\killstreaks\airdrop::getcratedropdestination(var_8, scripts\cp_mp\killstreaks\airdrop::getcratedropcastend(var_8, 1));

    if(!isDefined(var_5))
      return undefined;
  }

  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_8);
  var_10.angles = var_9;
  var_10 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_10.owner = var_0;
  var_10.team = var_1;
  var_10.hasowner = isDefined(var_0);
  var_11 = undefined;

  if(isDefined(var_6))
    var_11 = var_6.vehicleisreserved;

  var_12 = scripts\cp_mp\killstreaks\airdrop::createheli(var_0, var_1, var_8, var_9, var_11, var_7);

  if(!isDefined(var_12)) {
    var_10 delete();
    return undefined;
  }

  var_12 setup_pilot();
  var_12.scenenode = var_12;
  var_12 setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);
  var_12.animname = "_encstr_88F312368593CABEC1B08DB6583BACD734591B4B";
  var_12 thread watch_for_death();
  var_10.heli = var_12;
  var_10.heliendtime = gettime() + getanimlength(level.scr_anim["_encstr_88F312368593CABEC1B08DB6583BACD734591B4B"]["_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0"]) * 1000;
  var_10.latestanimendtime = var_10.heliendtime;
  var_13 = scripts\cp_mp\killstreaks\airdrop::createcrateforscripteddrop(var_0, var_1, var_2, var_5, undefined, 0, var_6, var_7, var_10, "_encstr_BAE50DE60E739BA638C72068AF47B9", "_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0");

  if(!isDefined(var_13))
    return undefined;

  var_14 = scripts\cp_mp\killstreaks\airdrop::createchuteforscripteddrop(var_10, var_13, "_encstr_859613C2D9CE6F2980CB7373E3106F3FFE503B3B21", "_encstr_875412B1C29CACF50E2C8DAD16762BEBC827BDE0");

  if(!isDefined(var_14))
    return undefined;

  var_14 setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);
  var_10 thread scripts\cp_mp\killstreaks\airdrop::watchdropcratefromscriptedheli();
  var_10.crate = var_13;
  return var_10;
}

watch_for_death() {
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.pilot))
    self.pilot delete();

  if(isDefined(self.copilot))
    self.copilot delete();
}

setup_pilot() {
  var_0 = "_encstr_BDF30A3B51CCFF9AC049F7D4";

  if(!self tagexists(var_0) && self tagexists("_encstr_AB680B55361AD76B09EB28E886"))
    var_0 = "_encstr_AB680B55361AD76B09EB28E886";

  if(!self tagexists(var_0)) {
    return;
  }
  var_1 = (0, 0, -20);
  var_2 = (0, 0, 0);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin(var_0));
  var_3 setModel("_encstr_967D148517D7E02DC6DB1DEB665D1B8D4C7B8C97F5C4");
  var_3 linkTo(self, var_0, var_1, var_2);
  var_3 scriptmodelplayanim("_encstr_B84A1673790882CCD038D6513378185BFD994FE3C3C91AAC");
  self.pilot = var_3;
}
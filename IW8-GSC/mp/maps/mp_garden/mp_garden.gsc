/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_garden\mp_garden.gsc
***********************************************/

main() {
  _encstr_8F3E31CA1763BACB808E3FBD1305A8BBC9E6B69F774FA7835B1F55CA9F09EF690791B644454B26934BDBDB528EE3FA3D1F0B89::main();
  _encstr_B8FE3090877A28E1BB2A7851C2261391C06FEAE8B33FA1FB031745E80DDA5BB8778F980147D9DBB91ABD506732C305C1735F::main();
  _encstr_888F2BE6D8E4A583A3CDBCD638BCDA58C1B9BCB6837DCE0B4E32957397ADE0EBCE169C8C2BDCBE66F0713BCDC6::main();
  _encstr_880B31D6B64BBB6B14972A20831780E313DA6051CA317FB1FAE37030967DFB67CAC6466D67FA4758D9172098B78651CD12EAB6::main();
  scripts\mp\load::main();
  level.music_style = "_encstr_BAFB08CA7376C616B932";
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_BE8F16A6201AA7CB93D89FCD46231E92934F12EF60CAA7A0", "_encstr_8D712078D72D5E4ECABB3DFB87C60F6F58D982E841D7A740B7C8B87791730365E868");
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  thread _id_1327B();
  thread spawn_carepackage();
  thread play_movie("_encstr_8CB70DD60EF5D92C9391599BFAA3EC");
  thread monitor();
  thread lb_pitch_roll_dmg_factor("_encstr_A6EB14C14F0550A6873829B3814FE590D5D16749FCAA", "_encstr_85140D93109201991FB9FBDBF5E74B", 0);
  thread lb_pitch_roll_dmg_factor("_encstr_A9E80CC1A03B73E23BC0B49B27C3", "_encstr_840B07B34FFDA388F0", 1);
  scripts\mp\flags::levelflagwait("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");
  wait 10.0;
  scripts\engine\utility::array_thread(getscriptablearray("_encstr_8537360F67CB5B708CA649804F7F9885C2B2DFB727F308D8BEFF16DB742BC0C8BB6AB947DBCA69C8CB971EB05A2F1873C2AF934917222180", "_encstr_AC110A7F14873B5B3D073009"), ::_id_141BD);
}

spawn_carepackage() {
  level waittill("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");

  if(scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B")) {
    var_0 = getEnt("_encstr_B40D0B593A250ADD6EAA0A08D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_0 hide();
  } else {
    var_1 = getEnt("_encstr_AD250E2A0AFC8FE53FCB32E028DF9752", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_1))
      var_1 hide();
  }
}

molotov_watch_cleanup_pool() {
  var_0 = easepower("_encstr_91FA11B685C143B4E6A37D7BCC33593996CDB3", level._id_11FAB.origin);
  waitframe();
  scripts\engine\scriptable::_id_12F5B("_encstr_91FA11B685C143B4E6A37D7BCC33593996CDB3", ::_id_11AE2);

  for(;;) {
    level waittill("_encstr_AB080FD39999954EB4E69D28D80B1B9519");
    monitor_enemy_death();
    wait 20;
    var_0 setscriptablepartstate("_encstr_91FA11B685C143B4E6A37D7BCC33593996CDB3", "_encstr_AB0703DBB9");
  }
}

monitor() {
  level._id_11FAB = scripts\engine\utility::getStruct("_encstr_BE340C70936EA9E56A6D5CC105E2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.getrandomprematchequipment = getEnt("_encstr_9ADF07B75BFB6360DA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.getrandomprematchequipment hide();
  level.getridofkillstreakdeployweapon = getEnt("_encstr_AC700CF06AB73B9B6F57B53D7FB7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.getridofkillstreakdeployweapon._id_1214A = level.getridofkillstreakdeployweapon.origin;
  level.getridofkillstreakdeployweapon.originalangles = level.getridofkillstreakdeployweapon.angles;
  level.getridofkillstreakdeployweapon hide();
  level.getrandomweaponfromgroup = scripts\engine\utility::getStructArray("_encstr_ACF70AB7D322C5E0E59560F9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.getrandomweaponfromgroup = scripts\engine\utility::array_randomize(level.getrandomweaponfromgroup);
  level.getrandomprematchequipment.origin = level.getrandomweaponfromgroup[0].origin;
  level.getrandomprematchequipment.angles = level.getrandomweaponfromgroup[0].angles;
  level._id_11D7B = getEntArray("_encstr_A3590AB167DF63DB033B28A8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_11D7A = scripts\engine\utility::getStructArray("_encstr_A22A0DDA7BAE372B8A930B0E62B7B1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in level._id_11D7A) {
    if(var_1.origin == (362.93, -1485.9, 0))
      var_1.origin = (358.93, -1465.9, 0);
  }

  level._id_11D7A = scripts\engine\utility::array_randomize(level._id_11D7A);
  level._id_11D7C = 0;
  var_3 = 0;

  foreach(var_5 in level._id_11D7B) {
    var_5.origin = level._id_11D7A[var_3].origin;
    var_5.angles = level._id_11D7A[var_3].angles;
    var_5.fx = scripts\engine\utility::spawn_tag_origin();
    var_5.fx.origin = var_5.origin;
    var_5.fx.angles = var_5.angles;
    var_5.fx show();
    thread _id_11D7D(var_5);
    var_3++;
  }

  level.gesture_checker = getEntArray("_encstr_ADAA07A701C57861C7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gesture_checker = scripts\engine\utility::array_randomize(level.gesture_checker);

  foreach(var_8 in level.gesture_checker) {
    var_8.fx = scripts\engine\utility::spawn_tag_origin();
    var_8.fx.origin = var_8.origin;
    var_8.fx.angles = var_8.angles;
    var_8.fx show();
    var_8 hide();
  }

  while(level._id_11D7C < 5)
    level waittill("_encstr_AAB60A2A27580E23DEEA9B8C");

  level.getsafeoriginaroundpoint = easepower("_encstr_A6C41005A7C30CB7853D5026326D40D3FD16", level.getridofkillstreakdeployweapon.origin + (0, 0, 6));
  waitframe();
  scripts\engine\scriptable::_id_12F5B("_encstr_A6C41005A7C30CB7853D5026326D40D3FD16", ::_id_11ADD);
  level waittill("_encstr_A7AD118686CA593759EAB291ECB215C2B62B9B");
  level.getridofkillstreakdeployweapon hide();
  level.getrandomprematchequipment show();
  level.getrewardvaluetype = easepower("_encstr_B8E00FB658C11A96E63A7DC61A9556B9B2", level.getrandomprematchequipment.origin + (0, 0, 6));
  waitframe();
  scripts\engine\scriptable::_id_12F5B("_encstr_B8E00FB658C11A96E63A7DC61A9556B9B2", ::_id_11ADE);
  level waittill("_encstr_A5E10C863C72EB737D430B586F9E");
  level.getrandomprematchequipment hide();
  var_10 = easepower("_encstr_91FA11B685C143B4E6A37D7BCC33593996CDB3", level._id_11FAB.origin);
  waitframe();
  scripts\engine\scriptable::_id_12F5B("_encstr_91FA11B685C143B4E6A37D7BCC33593996CDB3", ::_id_11AE2);
  level waittill("_encstr_AB080FD39999954EB4E69D28D80B1B9519");
  monitor_enemy_death();
}

_id_11D7D(var_0) {
  var_0 setCanDamage(1);
  var_0 waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
  var_0 hide();
  level._id_11D7C++;

  if(level._id_11D7C < 5) {
    playFXOnTag(scripts\engine\utility::getfx("_encstr_B89D109D661ED7D90B4E192B37FAD1C92CE0"), var_0.fx, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_0 playSound("_encstr_AFC616BA63C0EF2EE849EDFE2720B2C7FEF9A3018B2EAF22");
  } else {
    playFXOnTag(scripts\engine\utility::getfx("_encstr_ABA916CB64A9A90749F8E3EFF066EC83738719475BDD0244"), var_0.fx, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_0 playSound("_encstr_84D81CA287897A1A6E28214D5F280B6E4328E167EB0BA2739704B17A0A55");
    level.getridofkillstreakdeployweapon.origin = var_0.origin;
    level.getridofkillstreakdeployweapon.angles = var_0.angles;
    waittillframeend;
    level.getridofkillstreakdeployweapon show();
  }

  level notify("_encstr_AAB60A2A27580E23DEEA9B8C");
}

monitor_enemy_death() {
  level.getrandomprematchequipment.origin = level._id_11FAB.origin;
  level.getrandomprematchequipment.angles = level._id_11FAB.angles;
  level.getridofkillstreakdeployweapon.origin = level.getridofkillstreakdeployweapon._id_1214A;
  level.getridofkillstreakdeployweapon.angles = level.getridofkillstreakdeployweapon.originalangles;
  waittillframeend;
  level.getrandomprematchequipment show();
  wait 0.3;

  foreach(var_1 in level.gesture_checker) {
    var_1 show();
    waittillframeend;
    playFXOnTag(scripts\engine\utility::getfx("_encstr_AC95179B1270516160A60BA7AEE0D879CB148D39804340B50A"), var_1.fx, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.1;
  }

  level.getridofkillstreakdeployweapon show();
  wait 1;
  scripts\engine\utility::exploder("_encstr_87150BBFE11F012F8A0A208093");
  wait 15;
  level.getrandomprematchequipment hide();

  foreach(var_1 in level.gesture_checker) {
    killfxontag(scripts\engine\utility::getfx("_encstr_AC95179B1270516160A60BA7AEE0D879CB148D39804340B50A"), var_1.fx, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    playFXOnTag(scripts\engine\utility::getfx("_encstr_ABA916CB64A9A90749F8E3EFF066EC83738719475BDD0244"), var_1.fx, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.01;
    var_1 hide();
  }
}

_id_11AE2(var_0, var_1, var_2, var_3, var_4) {
  level thread allow_player_skip_laststand(var_0, var_1, var_2, var_3, var_4);
}

allow_player_skip_laststand(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "_encstr_AB0703DBB9") {
    var_0 setscriptablepartstate("_encstr_91FA11B685C143B4E6A37D7BCC33593996CDB3", "_encstr_BA19049F4B2D");
    var_3 playlocalsound("_encstr_A759133338C8824E136A42EA0139D7768A75EA2EFD");
    wait 0.3;
    level notify("_encstr_AB080FD39999954EB4E69D28D80B1B9519");
  }
}

_id_11ADE(var_0, var_1, var_2, var_3, var_4) {
  level thread allow_player_basejumping(var_0, var_1, var_2, var_3, var_4);
}

allow_player_basejumping(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "_encstr_AB0703DBB9") {
    var_0 setscriptablepartstate("_encstr_B8E00FB658C11A96E63A7DC61A9556B9B2", "_encstr_BA19049F4B2D");
    var_3 playlocalsound("_encstr_ADA81A8B09891060831A0B1102FBB0081C9D233FAD61203BF7D2E33B");
    level notify("_encstr_A5E10C863C72EB737D430B586F9E");
  }
}

_id_11ADD(var_0, var_1, var_2, var_3, var_4) {
  level thread allow_pickup_atmine(var_0, var_1, var_2, var_3, var_4);
}

allow_pickup_atmine(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "_encstr_AB0703DBB9") {
    var_0 setscriptablepartstate("_encstr_A6C41005A7C30CB7853D5026326D40D3FD16", "_encstr_BA19049F4B2D");
    level notify("_encstr_A7AD118686CA593759EAB291ECB215C2B62B9B");
  }
}

play_movie(var_0) {
  if(getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF") == 1) {
    return;
  }
  for(;;) {
    playcinematicforalllooping(var_0);
    wait 3;
  }
}

_id_1327B() {
  wait 1;
  var_0 = getEntArray("_encstr_ADA606A2E4B04BE6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_13CD2 = 15;
  wait(level._id_13CD2);

  foreach(var_2 in var_0) {
    switch (var_2.script_noteworthy) {
      case "_encstr_AA5606FD1AF05085":
        playFXOnTag(level._effect["_encstr_A9521B3BCC3CD7D92C938C59CDF5A39CC22DB9AF1ACA85468D2DEC1AA3"], var_2, "_encstr_AC8E18A9C547E0F9C939316151CD01C93B8487F5A94190D9B91C");
        playFXOnTag(level._effect["_encstr_A9521B3BCC3CD7D92C938C59CDF5A39CC22DB9AF1ACA85468D2DEC1AA3"], var_2, "_encstr_BD8E18CB7F6F11BCA7F9DF3BF19C6958A96D81F75E1778E42E4A");
        break;
      case "_encstr_AD1904A85C6C":
        break;
      case "_encstr_B69B0589C236B6":
        playFXOnTag(level._effect["_encstr_B1D41B3B66877DB32C2723CAB9F51DE42C5ADCD73A2C2DC6362D9DD01D"], var_2, "_encstr_AC8E18A9C547E0F9C939316151CD01C93B8487F5A94190D9B91C");
        playFXOnTag(level._effect["_encstr_B1D41B3B66877DB32C2723CAB9F51DE42C5ADCD73A2C2DC6362D9DD01D"], var_2, "_encstr_BD8E18CB7F6F11BCA7F9DF3BF19C6958A96D81F75E1778E42E4A");
        break;
      default:
        break;
    }

    thread _id_13CC9(var_2);
    var_2 thread _id_13C96();
  }
}

_id_13CC9(var_0) {
  var_1 = 0.00125;
  var_2 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    var_3 = abs(distance(var_0.origin, var_2.origin) * var_1);
    var_0 moveTo(var_2.origin, var_3, 0, 0);

    if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_B69B0589C236B6")
      var_0 rotateTo(var_2.angles + (0, 180, 0), var_3, 0, 0);
    else
      var_0 rotateTo(var_2.angles, var_3, 0, 0);

    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    wait(var_3);

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "_encstr_A26A09A3F2BD63A30FCA85") {
      var_0.origin = var_2.origin;

      if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_B69B0589C236B6")
        var_0.angles = var_2.angles + (0, 180, 0);
      else
        var_0.angles = var_2.angles;

      if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_AA5606FD1AF05085")
        level._id_13CD2 = randomint(30);

      switch (var_0.script_noteworthy) {
        case "_encstr_AA5606FD1AF05085":
          killfxontag(level._effect["_encstr_A9521B3BCC3CD7D92C938C59CDF5A39CC22DB9AF1ACA85468D2DEC1AA3"], var_0, "_encstr_AC8E18A9C547E0F9C939316151CD01C93B8487F5A94190D9B91C");
          killfxontag(level._effect["_encstr_A9521B3BCC3CD7D92C938C59CDF5A39CC22DB9AF1ACA85468D2DEC1AA3"], var_0, "_encstr_BD8E18CB7F6F11BCA7F9DF3BF19C6958A96D81F75E1778E42E4A");
          break;
        case "_encstr_AD1904A85C6C":
          break;
        case "_encstr_B69B0589C236B6":
          killfxontag(level._effect["_encstr_B1D41B3B66877DB32C2723CAB9F51DE42C5ADCD73A2C2DC6362D9DD01D"], var_0, "_encstr_AC8E18A9C547E0F9C939316151CD01C93B8487F5A94190D9B91C");
          killfxontag(level._effect["_encstr_B1D41B3B66877DB32C2723CAB9F51DE42C5ADCD73A2C2DC6362D9DD01D"], var_0, "_encstr_BD8E18CB7F6F11BCA7F9DF3BF19C6958A96D81F75E1778E42E4A");
          break;
        default:
          break;
      }

      wait(level._id_13CD2);

      switch (var_0.script_noteworthy) {
        case "_encstr_AA5606FD1AF05085":
          playFXOnTag(level._effect["_encstr_A9521B3BCC3CD7D92C938C59CDF5A39CC22DB9AF1ACA85468D2DEC1AA3"], var_0, "_encstr_AC8E18A9C547E0F9C939316151CD01C93B8487F5A94190D9B91C");
          playFXOnTag(level._effect["_encstr_A9521B3BCC3CD7D92C938C59CDF5A39CC22DB9AF1ACA85468D2DEC1AA3"], var_0, "_encstr_BD8E18CB7F6F11BCA7F9DF3BF19C6958A96D81F75E1778E42E4A");
          break;
        case "_encstr_AD1904A85C6C":
          break;
        case "_encstr_B69B0589C236B6":
          playFXOnTag(level._effect["_encstr_B1D41B3B66877DB32C2723CAB9F51DE42C5ADCD73A2C2DC6362D9DD01D"], var_0, "_encstr_AC8E18A9C547E0F9C939316151CD01C93B8487F5A94190D9B91C");
          playFXOnTag(level._effect["_encstr_B1D41B3B66877DB32C2723CAB9F51DE42C5ADCD73A2C2DC6362D9DD01D"], var_0, "_encstr_BD8E18CB7F6F11BCA7F9DF3BF19C6958A96D81F75E1778E42E4A");
          break;
        default:
          break;
      }

      var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    }
  }
}

_id_141BD() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(randomfloat(2));

  if(self getscriptablehaspart("_encstr_B4D5123696EC343AE6EB1B7B73D14EBD63D8CA93")) {
    if(self getscriptableparthasstate("_encstr_B4D5123696EC343AE6EB1B7B73D14EBD63D8CA93", "_encstr_992A0A97D753C508DF5D4159"))
      self setscriptablepartstate("_encstr_B4D5123696EC343AE6EB1B7B73D14EBD63D8CA93", "_encstr_992A0A97D753C508DF5D4159");
  }

  self.wire_think = scripts\engine\utility::spawn_tag_origin();
  self.wire_think.origin = self gettagorigin("_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  self.wire_think.angles = self gettagangles("_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  self.wire_think show();
  self.wire_think linkTo(self, "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118");
  waitframe();

  if(self.classname == "_encstr_8537360F67CB5B708CA649804F7F9885C2B2DFB727F308D8BEFF16DB742BC0C8BB6AB947DBCA69C8CB971EB05A2F1873C2AF934917222180")
    playFXOnTag(scripts\engine\utility::getfx("_encstr_A5D91967991EF5D90B39912BB9D70EED364BB195BEC6A576D0A36E"), self.wire_think, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  else
    return;

  for(;;) {
    self waittill("_encstr_937017E68D399638E816988DAC93BDE8B43396D82CD1A57BDC", var_0);

    if(var_0 == "_encstr_99220EEC59A15AD81B95EB91CA853AD0" || var_0 == "_encstr_AF790FF05D41D931214052FCA0E06102C6" || var_0 == "_encstr_8C0B1819A53025FF3582935A48161F1DA05F936FCBA02DDF65D9") {
      if(self.classname == "_encstr_8537360F67CB5B708CA649804F7F9885C2B2DFB727F308D8BEFF16DB742BC0C8BB6AB947DBCA69C8CB971EB05A2F1873C2AF934917222180")
        killfxontag(scripts\engine\utility::getfx("_encstr_A5D91967991EF5D90B39912BB9D70EED364BB195BEC6A576D0A36E"), self.wire_think, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

      self.wire_think delete();
      break;
    }
  }
}

lb_pitch_roll_dmg_factor(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 10;
  var_3 = getscriptablearray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = getEntArray(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_2) {
    var_3[0].showintelscriptablestoplayer = scripts\engine\utility::spawn_tag_origin();
    var_3[0].showintelscriptablestoplayer.origin = var_3[0] gettagorigin("_encstr_91CF1653C6DFF98A38B418500F6DABDDFD33261D9F975434");
    var_3[0].showintelscriptablestoplayer.angles = var_3[0] gettagangles("_encstr_91CF1653C6DFF98A38B418500F6DABDDFD33261D9F975434");
    var_3[0].showintelscriptablestoplayer show();
    var_3[0].showintelscriptablestoplayer linkTo(var_3[0], "_encstr_91CF1653C6DFF98A38B418500F6DABDDFD33261D9F975434");
    var_3[0].showintelinstancetoplayer = scripts\engine\utility::spawn_tag_origin();
    var_3[0].showintelinstancetoplayer.origin = var_3[0] gettagorigin("_encstr_BA6B157338FFF99B08AC7064A8313B3D05684968B0456B");
    var_3[0].showintelinstancetoplayer.angles = var_3[0] gettagangles("_encstr_BA6B157338FFF99B08AC7064A8313B3D05684968B0456B");
    var_3[0].showintelinstancetoplayer show();
    var_3[0].showintelinstancetoplayer linkTo(var_3[0], "_encstr_BA6B157338FFF99B08AC7064A8313B3D05684968B0456B");
    var_3[0]._id_13A29 = scripts\engine\utility::spawn_tag_origin();
    var_3[0]._id_13A29.origin = var_3[0] gettagorigin("_encstr_8D3F1505664A87B859B760B86F6AD1375201FE037F1269");
    var_3[0]._id_13A29.angles = var_3[0] gettagangles("_encstr_8D3F1505664A87B859B760B86F6AD1375201FE037F1269");
    var_3[0]._id_13A29 show();
    var_3[0]._id_13A29 linkTo(var_3[0], "_encstr_8D3F1505664A87B859B760B86F6AD1375201FE037F1269");
    var_3[0]._id_13A28 = scripts\engine\utility::spawn_tag_origin();
    var_3[0]._id_13A28.origin = var_3[0] gettagorigin("_encstr_BEF9144927D208C8D96FB04B19BAE85E4A7781E3A30B");
    var_3[0]._id_13A28.angles = var_3[0] gettagangles("_encstr_BEF9144927D208C8D96FB04B19BAE85E4A7781E3A30B");
    var_3[0]._id_13A28 show();
    var_3[0]._id_13A28 linkTo(var_3[0], "_encstr_BEF9144927D208C8D96FB04B19BAE85E4A7781E3A30B");
    waitframe();
    playFXOnTag(scripts\engine\utility::getfx("_encstr_A7E325D39C6896F7D1E27D13C0CF1083FBA2684BF80BF5F9634BBD8FBFD9062A5526DAF051D3A8"), var_3[0].showintelscriptablestoplayer, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    playFXOnTag(scripts\engine\utility::getfx("_encstr_B6BA2483D728A9E44AABA1BBC371BBB0C9AF48F83F90A8B0F2DFBD9F0B6A777065C9B0F1E7D4"), var_3[0].showintelinstancetoplayer, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    playFXOnTag(scripts\engine\utility::getfx("_encstr_AA5E25E6BC82F75F43E8323A10E753C71811746144E8036971B89A5378E94E337110D2E9EC30CB"), var_3[0]._id_13A29, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    playFXOnTag(scripts\engine\utility::getfx("_encstr_B2F5244B1FF0713C825369630B49FDD889F57020C758E0F8AA17455753224F885D81F8392FAC"), var_3[0]._id_13A28, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  }

  if(isDefined(var_3) && isDefined(var_3[0])) {
    var_5 = var_3[0];
    var_6 = 1;

    while(var_6) {
      var_5 waittill("_encstr_937017E68D399638E816988DAC93BDE8B43396D82CD1A57BDC", var_7, var_8);

      switch (var_7) {
        case "_encstr_866307EDCD995AC9AC":
        case "_encstr_86390885FB5A76782D42":
        case "_encstr_99220EEC59A15AD81B95EB91CA853AD0":
          trucklightsoff(var_4);

          if(var_2) {
            killfxontag(scripts\engine\utility::getfx("_encstr_A7E325D39C6896F7D1E27D13C0CF1083FBA2684BF80BF5F9634BBD8FBFD9062A5526DAF051D3A8"), var_3[0].showintelscriptablestoplayer, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
            killfxontag(scripts\engine\utility::getfx("_encstr_B6BA2483D728A9E44AABA1BBC371BBB0C9AF48F83F90A8B0F2DFBD9F0B6A777065C9B0F1E7D4"), var_3[0].showintelinstancetoplayer, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
            killfxontag(scripts\engine\utility::getfx("_encstr_AA5E25E6BC82F75F43E8323A10E753C71811746144E8036971B89A5378E94E337110D2E9EC30CB"), var_3[0]._id_13A29, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
            killfxontag(scripts\engine\utility::getfx("_encstr_B2F5244B1FF0713C825369630B49FDD889F57020C758E0F8AA17455753224F885D81F8392FAC"), var_3[0]._id_13A28, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
          }

          var_6 = 0;
          return;
        case "_encstr_AF790FF05D41D931214052FCA0E06102C6":
          trucklightsoff(var_4);

          if(var_2) {
            killfxontag(scripts\engine\utility::getfx("_encstr_A7E325D39C6896F7D1E27D13C0CF1083FBA2684BF80BF5F9634BBD8FBFD9062A5526DAF051D3A8"), var_3[0].showintelscriptablestoplayer, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
            killfxontag(scripts\engine\utility::getfx("_encstr_B6BA2483D728A9E44AABA1BBC371BBB0C9AF48F83F90A8B0F2DFBD9F0B6A777065C9B0F1E7D4"), var_3[0].showintelinstancetoplayer, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
            killfxontag(scripts\engine\utility::getfx("_encstr_AA5E25E6BC82F75F43E8323A10E753C71811746144E8036971B89A5378E94E337110D2E9EC30CB"), var_3[0]._id_13A29, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
            killfxontag(scripts\engine\utility::getfx("_encstr_B2F5244B1FF0713C825369630B49FDD889F57020C758E0F8AA17455753224F885D81F8392FAC"), var_3[0]._id_13A28, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
          }

          var_6 = 0;
          return;
      }
    }
  }
}

trucklightsoff(var_0) {
  foreach(var_2 in var_0)
  var_2 setlightintensity(0);
}

_id_13C96() {
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  var_0 endon("_encstr_AD75063D571AE108");
  thread scripts\engine\utility::delete_on_death(var_0);
  var_1 = "_encstr_B40101";

  switch (self.script_noteworthy) {
    case "_encstr_AA5606FD1AF05085":
      var_1 = "_encstr_813C1C83288168FF830291F8D9E3A7902292136FAC75E8340F3A0BC0F22B";
      break;
    case "_encstr_AD1904A85C6C":
      var_1 = "_encstr_B1471DD0BB690FE903B465E8B733D1EFCA02F8B992BDA561DFD57BD564AB99";
      break;
    case "_encstr_B69B0589C236B6":
      var_1 = "_encstr_A3391BF3738FA7FFD2A18398015349AF78399047080FDD686925611A47";
      break;
    default:
      break;
  }

  switch (self.script_noteworthy) {
    case "_encstr_B69B0589C236B6":
    case "_encstr_AA5606FD1AF05085":
      var_0 linkTo(self, "_encstr_AC8E18A9C547E0F9C939316151CD01C93B8487F5A94190D9B91C");
      break;
    default:
      var_0 linkTo(self);
      break;
  }

  wait 0.05;
  var_0 playLoopSound(var_1);
  var_0 waittill("_encstr_9B8F0BAE0BE2F1097BBF50807B" + var_1);
  var_0 stoploopsound(var_1);
  var_0 delete();
}
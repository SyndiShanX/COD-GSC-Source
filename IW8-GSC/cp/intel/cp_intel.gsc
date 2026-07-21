/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\intel\cp_intel.gsc
***********************************************/

intel_init() {
  level.intel_drops = [];
  level.intel_drop_num = 0;
  level.intel_level = 0;
  level.transientname = [];
  level.no_intel_drops = 1;
  level.intel_drop_func = ::drop_intel_piece;
  level.should_intel_drop_func = ::should_drop_intel_piece;
  level.playerclearstreamhintorigin = ::spawn_another_group_and_run_regular_death;
  scripts\engine\utility::flag_init("_encstr_8FF417022583A81928E067459A1A1E2142305C1BD9C990BB21");

  if(scripts\engine\utility::flag_exist("_encstr_8BA416297AC063070845C4D98B2F7FA1BBF78297FD679EAF"))
    scripts\engine\utility::flag_wait("_encstr_8BA416297AC063070845C4D98B2F7FA1BBF78297FD679EAF");

  scripts\cp\cp_agent_damage::register_drop_func("_encstr_A98F06181E4BCA85", ::drop_intel_piece, ::should_drop_intel_piece, 15);
  level thread test_intel_pickup();
}

should_drop_intel_piece(var_0) {
  if(isDefined(level.should_drop_intel_func))
    return [[level.should_drop_intel_func]](var_0);

  if(istrue(level.no_intel_drops))
    return 0;

  if(istrue(self.force_intel_drop))
    return 1;

  var_1 = randomint(100);

  if(var_1 > 20)
    return 0;

  return 1;
}

drop_intel_piece(var_0) {
  self notify("_encstr_B8CB0F83F5B80B7848302F39C8A8A49281");
  var_1 = init_first_button();
  level.intel_drops = scripts\engine\utility::array_add(level.intel_drops, var_1);

  if(isDefined(self.traincar_wait_until_shown))
    var_1.traincar_wait_until_shown = self.traincar_wait_until_shown;

  waitframe();
  _id_11A88(var_1);
  tag_intel_with_head_icon(var_1);

  if(isDefined(var_1.traincar_wait_until_shown))
    level notify("_encstr_8D1D14ADB17D1C98AFA5DCA3CA1BEB3293ED38839523", var_1);
  else
    level notify("_encstr_8D1D14ADB17D1C98AFA5DCA3CA1BEB3293ED38839523");
}

init_first_button() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + (0, 0, 5));
  var_0 setModel("_encstr_974B19B28974EB1620913F1FAB815E07A920BB4A30D897C150993C");
  return var_0;
}

_id_11A88(var_0) {
  var_1 = &"_encstr_B14E11E74948C0B2A2FC5DD315D1F7D8A61F33";
  var_0 setHintString(var_1);
  var_0 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_0 sethintdisplayrange(500);
  var_0 sethintdisplayfov(65);
  var_0 setuserange(72);
  var_0 setusefov(65);
  var_0 sethintonobstruction("_encstr_BD1805CB69C063");
  var_0 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_0 makeusable();
  var_0 thread use_think();
  return var_0;
}

use_think() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_8F9C1622904FF22E0E6BB6A47530CFBB4BE02A2AA1976BF3");
  level endon("_encstr_8D7718BDE3B942E7A1337503B0E8D9E36AD8EA79CA153DA8EC99");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(isDefined(var_0)) {
      if(!var_0 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      var_1 = undefined;

      if(isDefined(self.traincar_wait_until_shown))
        var_1 = self.traincar_wait_until_shown;

      level thread collect_intel(var_0, var_1);
      remove_intel_piece();
    }
  }
}

tag_intel_with_head_icon(var_0) {
  if(!isDefined(level.intel_headicons))
    level.intel_headicons = [];

  var_0.head_icon = deleteheadicon(var_0);
  setheadiconfriendlyimage(var_0.head_icon, "_encstr_8E781B0D5D19BED2B1BD377D0D0B4E8C83F62D37A3EB8C5A0BD6B77323");
  setheadiconsnaptoedges(var_0.head_icon, 0);
  level.intel_headicons[level.intel_headicons.size] = var_0.head_icon;
}

collect_intel(var_0, var_1) {
  var_0 thread _id_123F5();
  var_0 give_intel_weapon();
  level.intel_level++;

  if(isDefined(var_1))
    level notify("_encstr_83501271A2A978698F27E223D390D1176F45307A", var_1);
  else
    level notify("_encstr_83501271A2A978698F27E223D390D1176F45307A");
}

_id_123F5() {
  if(isDefined(level.train_delay_handler))
    [[level.train_delay_handler]](self);
  else
    scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "_encstr_8538173B538A5860952969E00D4C2B86032FAFBB3BC29EF0B3");
}

give_intel_weapon(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = "_encstr_8F7F1323EA8B41BC6F3BD81EA0FD13607820678251";

  if(isDefined(var_0))
    var_1 = var_0;

  if(getDvar("_encstr_AA65166E36C9FAA395DCE87D5A9BE82B63EB83B41BD6D538") != "_encstr_B40101")
    var_1 = getDvar("_encstr_AA65166E36C9FAA395DCE87D5A9BE82B63EB83B41BD6D538");

  var_2 = get_intel_omnvar(var_1);
  self disableweaponswitch();
  scripts\common\utility::allow_mantle(0);
  scripts\common\utility::allow_prone(0);
  scripts\common\utility::allow_melee(0);
  scripts\common\utility::allow_offhand_weapons(0);
  scripts\common\utility::allow_weapon_pickup(0);
  vehicle_allowplayeruse(self, 0);
  var_3 = scripts\cp\utility::getvalidtakeweapon();
  var_4 = getcompleteweaponname(var_1);
  scripts\cp\utility::_giveweapon(var_4);
  self switchtoweapon(var_4);
  self setclientomnvar("_encstr_9B9C0E4F4B38D3F19808276B86C82B6A", var_2);
  var_5 = get_intel_weapon_hold_time(var_1);
  wait(var_5);
  self takeweapon(var_4);
  self switchtoweapon(var_3);
  self enableweaponswitch();
  scripts\common\utility::allow_mantle(1);
  scripts\common\utility::allow_prone(1);
  scripts\common\utility::allow_melee(1);
  scripts\common\utility::allow_offhand_weapons(1);
  vehicle_allowplayeruse(self, 1);
  scripts\common\utility::allow_weapon_pickup(1);
  self setclientomnvar("_encstr_9B9C0E4F4B38D3F19808276B86C82B6A", 0);
}

get_intel_weapon_hold_time(var_0) {
  switch (var_0) {
    case "_encstr_8F7F1323EA8B41BC6F3BD81EA0FD13607820678251":
      return 4;
    case "_encstr_A7FB114B37E8958DEB6C58C61BD7C186B7E62B":
      return 3;
    case "_encstr_B65F184BDC3AB236EBE05D8ED75D6E13BEA5CDFA4758C46359A3":
      return 4;
    case "_encstr_9BDA102D73D156D8F533ED57DC91FABA374C":
      return 4;
  }

  return 5;
}

get_intel_omnvar(var_0) {
  switch (var_0) {
    case "_encstr_8F7F1323EA8B41BC6F3BD81EA0FD13607820678251":
      return 1;
    case "_encstr_A7FB114B37E8958DEB6C58C61BD7C186B7E62B":
      return 2;
    case "_encstr_B65F184BDC3AB236EBE05D8ED75D6E13BEA5CDFA4758C46359A3":
      return 3;
    case "_encstr_9BDA102D73D156D8F533ED57DC91FABA374C":
      return 8;
  }

  return 0;
}

test_intel_pickup() {
  while(!isDefined(level.players) || level.players.size < 1)
    wait 0.1;

  if(getDvar("_encstr_AA65166E36C9FAA395DCE87D5A9BE82B63EB83B41BD6D538") != "_encstr_B40101") {
    wait 5;
    var_0 = anglesToForward(level.players[0] getplayerangles());
    var_0 = vectorNormalize(var_0);
    var_0 = var_0 * 30;
    var_1 = level.players[0].origin;
    var_2 = (0, 0, 0);
    var_3 = scripts\engine\utility::spawn_script_origin(var_1 + var_0, var_2);
    var_3 linkTo(level.players[0]);

    for(;;) {
      var_3 drop_intel_piece();
      level waittill("_encstr_83501271A2A978698F27E223D390D1176F45307A");
      wait 3;
    }
  }
}

remove_intel_piece() {
  playFX(level._effect["_encstr_AB751081D3031ACA6D2F289D47B2A85F125F"], self.origin);
  level.intel_drops = scripts\engine\utility::array_remove(level.intel_drops, self);

  if(isDefined(self.head_icon)) {
    if(scripts\engine\utility::array_contains(level.intel_headicons, self.head_icon)) {
      if(isDefined(self.head_icon)) {
        level.intel_headicons = scripts\engine\utility::array_remove(level.intel_headicons, self.head_icon);
        setheadiconimage(self.head_icon);
      }
    }
  }

  self delete();
}

timeout_remove_intel(var_0) {
  self endon("_encstr_AD75063D571AE108");
  wait(var_0);
  level notify("_encstr_8F9C1622904FF22E0E6BB6A47530CFBB4BE02A2AA1976BF3");
  remove_intel_piece();
}

remove_when_no_one_around() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = 4000;
  var_1 = var_0 * var_0;

  for(;;) {
    var_2 = 0;

    foreach(var_4 in level.players) {
      if(var_2) {
        continue;
      }
      if(distance2dsquared(var_4.origin, self.origin) < var_1)
        var_2 = 1;
    }

    if(!var_2) {
      break;
    }

    wait 1;
  }

  level notify("_encstr_8D7718BDE3B942E7A1337503B0E8D9E36AD8EA79CA153DA8EC99");
  remove_intel_piece();
}

publiceventsmanager(var_0) {
  var_1 = strtok(var_0, "_encstr_BA4C02DF");
  var_2 = var_1[0];
  var_3 = int(var_1[1]);
  var_4 = 0;

  switch (var_2) {
    case "_encstr_8D06078C95858DAC27":
      break;
    case "_encstr_91EE088C2B16632B4EC8":
      var_4 = 5;
      break;
    case "_encstr_BA090995A1F8EC42C89DE3":
      var_4 = 10;
      break;
    case "_encstr_9AC90AB12128FC1B20408903":
      var_4 = 15;
      break;
    case "_encstr_B8010A3D97C3CA5499A8D783":
      var_4 = 20;
      break;
    case "_encstr_974B0B8269FDF35778BD051A15":
      var_4 = 25;
      break;
    case "_encstr_BD50097A1143DAD738900B":
      var_4 = 30;
      break;
    case "_encstr_8DDF0A6ED65D3B3BB1B22791":
      var_4 = 35;
      break;
    default:
      break;
  }

  var_5 = var_4 + var_3;
  return var_5;
}

shared_interaction_structs(var_0, var_1) {
  var_2 = 1;
  var_2 = publiceventsmanager(var_0);
  var_3 = 0;
  var_3 = self getplayerdata("_encstr_850703B7D9", "_encstr_87BC08E361C91D5B3D18", var_2);
  return var_3;
}

unlock_player_intel(var_0, var_1) {
  var_2 = 1;
  var_2 = publiceventsmanager(var_0);
  self setplayerdata("_encstr_850703B7D9", "_encstr_87BC08E361C91D5B3D18", var_2, 1);
  self setplayerdata("_encstr_850703B7D9", "_encstr_913A0B08EFCF46CC52B5ED9B23", var_2, 1);
  thread scripts\cp\cp_hud_message::showsplash("_encstr_B1271406C8C7901DDB9AB02162B63F686F4698853EF3", undefined, self);
}

piece_use() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = &"_encstr_B14E11E74948C0B2A2FC5DD315D1F7D8A61F33";
  self setHintString(var_0);
  self setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_1 = 500;

  if(self.script_noteworthy == "_encstr_B8620ACF79D8BC9AFEA5C77A")
    var_1 = 130;

  self sethintdisplayrange(var_1);
  self sethintdisplayfov(65);
  self setuserange(72);
  self setusefov(65);
  self sethintonobstruction("_encstr_BECC055CF3811A");
  self setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  self makeusable();
  level.transientname[level.transientname.size] = self;

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(isDefined(var_2)) {
      if(!var_2 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(!var_2 shared_interaction_structs(self.script_noteworthy))
        thread helis_assault3_check_size(var_2);
    }
  }
}

helis_assault3_check_size(var_0) {
  switch (self.model) {
    case "_encstr_B6171CED450A9FDB22F73070BF5BF6FB336E48EDDCE37BC127F3D878C365":
      self hidefromplayer(var_0);
      self disableplayeruse(var_0);
      var_0 give_intel_weapon("_encstr_9BDA102D73D156D8F533ED57DC91FABA374C");
      thread scramblebink(var_0);
      break;
    case "_encstr_974B19B28974EB1620913F1FAB815E07A920BB4A30D897C150993C":
      self hidefromplayer(var_0);
      self disableplayeruse(var_0);
      var_0 give_intel_weapon("_encstr_8F7F1323EA8B41BC6F3BD81EA0FD13607820678251");
      thread scramblebink(var_0);
      break;
    case "_encstr_955C19629998B3E5389F0F37AD582C0F3D76CA4A40ED679AE1517A":
    case "_encstr_82CD1358122127319B61BEA57FEB19A1177B91FA9F":
      var_0 scripts\cp\utility::playerplaytakephotoanim();
      self hidefromplayer(var_0);
      self disableplayeruse(var_0);
      thread scramblebink(var_0);
      break;
    default:
      break;
  }
}

scramblebink(var_0) {
  var_0 unlock_player_intel(self.script_noteworthy);
}

init_intel_pieces(var_0, var_1) {
  level.tracktimeringingfrenzy = 1;
  var_3 = "_encstr_847614C607F5C8DE37593ACD5BD7A5378EB2C6D71B9B";

  if(isDefined(var_1))
    var_3 = var_1;

  if(!scripts\engine\utility::flag_exist(var_3 + "_encstr_93D80BF536F6B638D8AC1D95C8"))
    scripts\engine\utility::flag_init(var_3 + "_encstr_93D80BF536F6B638D8AC1D95C8");

  scripts\engine\utility::flag_wait(var_3 + "_encstr_93D80BF536F6B638D8AC1D95C8");

  if(!level.tracktimeringingfrenzy)
    var_0 = "_encstr_824209F5B85FA1888CD16D";

  var_4 = getEntArray("_encstr_88BE0CF1785B7319316320378731", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_6 in var_4) {
    var_7 = strtok(var_6.script_noteworthy, "_encstr_BA4C02DF");
    var_8 = var_7[0];

    if(var_8 == var_0) {
      var_6 thread piece_use();
      continue;
    }

    var_6 delete();
  }

  wait 1;
  scripts\engine\utility::flag_set("_encstr_8FF417022583A81928E067459A1A1E2142305C1BD9C990BB21");
}

spawn_another_group_and_run_regular_death() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::flag_wait("_encstr_8FF417022583A81928E067459A1A1E2142305C1BD9C990BB21");

  if(!isDefined(self)) {
    return;
  }
  foreach(var_2 in level.transientname) {
    if(shared_interaction_structs(var_2.script_noteworthy)) {
      var_2 hidefromplayer(self);
      var_2 disableplayeruse(self);
    }
  }
}
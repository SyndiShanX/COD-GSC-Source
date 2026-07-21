/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_computerscreen.gsc
***********************************************/

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

init_computer_anims() {
  level.scr_animtree["_encstr_836714DB686975184BFDD2D325B06F724F103BC34D82"] = #animtree;
  level.scr_anim["_encstr_836714DB686975184BFDD2D325B06F724F103BC34D82"]["_encstr_99AD06D3A5B1538B"] = % _encstr_B8B32446AFAFDB861BE9E0438B8897091D0A4B2770459BF426932AB610C67057F9430D8857A5;
  level.scr_animname["_encstr_836714DB686975184BFDD2D325B06F724F103BC34D82"]["_encstr_99AD06D3A5B1538B"] = "_encstr_B8B32446AFAFDB861BE9E0438B8897091D0A4B2770459BF426932AB610C67057F9430D8857A5";
  level.scr_eventanim["_encstr_836714DB686975184BFDD2D325B06F724F103BC34D82"]["_encstr_99AD06D3A5B1538B"] = "_encstr_A26310353B8257BAF7CB4B5B2D93CB79A94E";
  level.scr_anim["_encstr_836714DB686975184BFDD2D325B06F724F103BC34D82"]["_encstr_B419059BD17BE0"] = % _encstr_B1B52366CA2137A1BA6738103FC47E4F8A3567F5237AFD289E0BE8380B19318BD15FDB73BB;
  level.scr_animname["_encstr_836714DB686975184BFDD2D325B06F724F103BC34D82"]["_encstr_B419059BD17BE0"] = "_encstr_B1B52366CA2137A1BA6738103FC47E4F8A3567F5237AFD289E0BE8380B19318BD15FDB73BB";
  level.scr_eventanim["_encstr_836714DB686975184BFDD2D325B06F724F103BC34D82"]["_encstr_B419059BD17BE0"] = "_encstr_B1F011E0872DAE87CA6D179D0342ED169F3770";
  level.scr_anim["_encstr_836714DB686975184BFDD2D325B06F724F103BC34D82"]["_encstr_95FE09AB6E2BD763DBDE07"] = % _encstr_8B9723D807D7DCD89CD2078E2B8CF5B1B75BC1D5A35693A5371D594E992CC695D79623B12B;
  level.scr_animname["_encstr_836714DB686975184BFDD2D325B06F724F103BC34D82"]["_encstr_95FE09AB6E2BD763DBDE07"] = "_encstr_8B9723D807D7DCD89CD2078E2B8CF5B1B75BC1D5A35693A5371D594E992CC695D79623B12B";
  level.scr_eventanim["_encstr_836714DB686975184BFDD2D325B06F724F103BC34D82"]["_encstr_95FE09AB6E2BD763DBDE07"] = "_encstr_AD2812EBDB7D57265FA72383BDC7AD618D8A9DCB";
}

create_computer_interaction(var_0, var_1, var_2, var_3) {
  var_4 = "_encstr_81190401EA65" + var_1 + "_encstr_A1950FE70E1937326FE069B3A0672BDBD3";
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_5.computer_name = var_4;
  var_5.popup_omnvar = var_1;
  var_5 scripts\cp\utility::sethintobject(undefined, "_encstr_BA110C20C7C0F307EDF9111CB7A1", "_encstr_AD361D5AA1786B0160239180274895CB8859D372C94EF706C813828BC3881F", &"_encstr_81F4146F09E1DBFB929C8AFD472FD03E8E51C5E9E921", 25, "_encstr_97C20EB5FD43A179CC6AD05152651579", "_encstr_BD1805CB69C063", 256, 120, 48, 90);
  var_5 thread computer_think(var_1, var_3, var_2);
  var_5 thread computer_event_listener(var_4);
  var_5 thread computer_watch_for_search(var_4);
  return var_5;
}

computer_think(var_0, var_1, var_2) {
  self notify("_encstr_B16B0FD7AFC22FB0547F63DE23201868DA");
  self endon("_encstr_B16B0FD7AFC22FB0547F63DE23201868DA");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_3);

    if(!var_3 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    level notify("_encstr_91B517B6C29B4B99599B477DB1EDAD07AEE85993EBD5DC9519", var_3);
    self makeunusable();
    thread computer_think_internal(var_3, var_0, var_1, var_2);
  }
}

computer_think_internal(var_0, var_1, var_2, var_3) {
  self notify("_encstr_BDEE18D6B8CB136D9308E34F984839BABFD8DC0D9D73EB8ED968");
  self endon("_encstr_BDEE18D6B8CB136D9308E34F984839BABFD8DC0D9D73EB8ED968");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  computer_player_allow(var_0, 0);
  thread computer_laststand_handler(var_0, var_1);
  thread computer_disconnect_handler(var_0);

  while(var_0 useButtonPressed())
    wait 0.05;

  var_0 playlocalsound("_encstr_91DF104E03588A27AFE3BB7BD7E3DFA33F0D");
  self.scenenode = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("_encstr_B1E00D1B0EBABE579BB27DE638DE3A", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"));
  scripts\engine\utility::delaythread(1, ::computer_activate, var_0, var_1, var_2, var_3);
  do_computer_anims(var_0);
  computer_player_allow(var_0, 1);
  var_0 setclientomnvar("_encstr_B6530B0F9BD6B24997B8B033F8", 0);

  if(!istrue(self.disable_playeruse))
    self makeusable();
}

computer_activate(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && isDefined(var_3))
    setomnvar(var_2, var_3);

  var_0 setclientomnvar("_encstr_B6530B0F9BD6B24997B8B033F8", var_1);
}

do_computer_anims(var_0) {
  init_computer_anims();

  if(getdvarint("_encstr_A2A31865319771B97D9AC881B3567D8873B47DEDAF87D8FB6563") > 0)
    var_0 thread computer_anim_loop_exit(var_0);
  else {
    var_1 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_0, "_encstr_836714DB686975184BFDD2D325B06F724F103BC34D82", 1, 0);
    var_2 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_1], "_encstr_99AD06D3A5B1538B", 1, 0) && var_0 scripts\cp_mp\utility\player_utility::_isalive();
    var_0 thread computer_anim_loop_exit(var_0);
    self.scenenode computer_anim_loop(var_0, var_1);
    self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_1], "_encstr_B419059BD17BE0", 0, 1);
  }
}

computer_anim_loop(var_0, var_1) {
  var_0 endon("_encstr_96F30E25E03F131F7E5AD83893D313AB");

  while(var_0 scripts\cp_mp\utility\player_utility::_isalive())
    scripts\cp_mp\anim_scene::anim_scene([var_1], "_encstr_95FE09AB6E2BD763DBDE07", 0, 0);
}

computer_anim_loop_exit(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_96F30E25E03F131F7E5AD83893D313AB");
  level._id_1404B = 1;

  if(var_0 usinggamepad()) {
    if(istrue(level._id_1404B)) {
      while(var_0 useButtonPressed())
        wait 0.05;
    } else {
      while(var_0 stancebuttonPressed())
        wait 0.05;
    }
  } else {
    while(var_0 useButtonPressed())
      wait 0.05;
  }

  for(;;) {
    if(var_0 usinggamepad()) {
      if(istrue(level._id_1404B)) {
        if(var_0 useButtonPressed()) {
          break;
        }
      } else if(var_0 stancebuttonPressed()) {
        break;
      }
    } else if(var_0 useButtonPressed()) {
      break;
    }

    wait 0.05;
  }

  var_0 playlocalsound("_encstr_991511D629C9C62FA317EB6039EBE0A7E3EB84");
  var_0 notify("_encstr_96F30E25E03F131F7E5AD83893D313AB");
}

computer_disconnect_handler(var_0) {
  var_0 endon("_encstr_96F30E25E03F131F7E5AD83893D313AB");
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  self makeusable();
}

computer_laststand_handler(var_0, var_1) {
  var_0 endon("_encstr_96F30E25E03F131F7E5AD83893D313AB");
  var_0 waittill("_encstr_8CBE0BD1BED30936AB03C0B02B");
  computer_player_allow(var_0, 1);

  if(isDefined(var_1))
    var_0 setclientomnvar("_encstr_B6530B0F9BD6B24997B8B033F8", var_1);

  self makeusable();
  var_0 notify("_encstr_96F30E25E03F131F7E5AD83893D313AB");
}

computer_player_allow(var_0, var_1) {
  var_0 scripts\common\utility::allow_crouch(var_1);
  var_0 scripts\common\utility::allow_prone(var_1);
  var_0 scripts\common\utility::allow_weapon(var_1);
  var_0._id_140AE = !var_1;
  var_0.disable_super = !var_1;
}

computer_event_listener(var_0) {
  for(;;) {
    level waittill("_encstr_92201938B158E559E4EB36BDB683AEA35693EBDC9558938D342BC8", var_1, var_2, var_3);

    if(var_2 != var_0) {
      continue;
    }
    self notify("_encstr_91F90FB1BDB583BA472BC9FAACB3593747", var_1, var_3);
  }
}

computer_watch_for_search(var_0) {
  for(;;) {
    level waittill("_encstr_B6211C13600823633A012F303D470B24DD7250C2392036F4CF571FB2E96B", var_1, var_2, var_3);

    if(var_2 != var_0) {
      continue;
    }
    self notify("_encstr_A16413872F65B88DE37A6BF6239F4F603EB01B65CF", var_1, var_3);
  }
}

hit_by_emp_monitor(var_0) {
  var_0 notify("_encstr_BDA9193E555A692BF4EFE091C736C38B13BFA7B6AF1139B0C12B20");
  var_0 endon("_encstr_BDA9193E555A692BF4EFE091C736C38B13BFA7B6AF1139B0C12B20");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(var_0 useButtonPressed())
    wait 0.05;

  thread computer_laststand_handler(var_0);
  thread computer_disconnect_handler(var_0);
  var_0 playlocalsound("_encstr_91DF104E03588A27AFE3BB7BD7E3DFA33F0D");
  self.scenenode = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("_encstr_B1E00D1B0EBABE579BB27DE638DE3A", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"));
  computer_player_allow(var_0, 0);
  do_computer_anims(var_0);
  computer_player_allow(var_0, 1);
}
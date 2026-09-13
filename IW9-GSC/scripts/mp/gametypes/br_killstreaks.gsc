/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_killstreaks.gsc
***************************************************/

init() {
  level._id_6E488F8EA3D98872 = getdvarint("dvar_B59AB75A606E3255", 1);
}

playercanpickupkillstreak() {
  return !isDefined(self.brkillstreak);
}

takekillstreakpickup(pickupent) {
  _id_608A1457B732069E = level.br_pickups.br_equipname[pickupent.scriptablename];
  self.brkillstreak = _id_608A1457B732069E;
  playerkillstreakhud(_id_608A1457B732069E);
  playergivetriggerweapon();
  thread playerhandlekillstreak(_id_608A1457B732069E);
}

playerkillstreakhud(streakname) {
  self.brkillstreakhudlabel = scripts\mp\hud_util::createfontstring("default", 0.75);
  self.brkillstreakhudlabel scripts\mp\hud_util::setpoint("CENTER", "BOTTOM LEFT", 270, -70);
  self.brkillstreakhudlabel.label = &"MP/BR_ACTIVATE_KILLSTREAK";
  _id_D442547D75DFFD09 = level._id_0B23156D776B1D85._id_038F2A11237246AC[streakname];
  icon = scripts\engine\utility::ter_op(isDefined(_id_D442547D75DFFD09) && isDefined(_id_D442547D75DFFD09.hudicon), _id_D442547D75DFFD09._id_80437C37A4E0AA29, "");
  self.brkillstreakhudicon = scripts\mp\hud_util::createicon(icon, 30, 30);
  self.brkillstreakhudicon scripts\mp\hud_util::setpoint("CENTER", "BOTTOM LEFT", 270, -45);
}

playergivetriggerweapon() {
  self giveweapon("super_default_mp");
  self setweaponammoclip("super_default_mp", 1);
  self assignweaponoffhandspecial("super_default_mp");
}

playerhandlekillstreak(_id_608A1457B732069E) {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("special_weapon_fired", objweapon);
    result = playertriggerkillstreak();

    if(result) {
      playerremovekillstreak();
      return;
    } else
      self setweaponammoclip("super_default_mp", 1);
  }
}

playertriggerkillstreak() {
  if(!isalive(self))
    return 0;

  struct = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(self.brkillstreak);
  result = scripts\mp\killstreaks\killstreaks::triggerkillstreak(struct);
  return istrue(result);
}

playerremovekillstreak() {
  self takeweapon("super_default_mp");
  self.brkillstreak = undefined;

  if(isDefined(self.brkillstreakhudlabel))
    self.brkillstreakhudlabel destroy();

  if(isDefined(self.brkillstreakhudicon))
    self.brkillstreakhudicon destroy();
}

_id_90E0F83E97306BFF(players, _id_1022173EA86A7090, _id_334D3B08AEF373D4) {
  if(!isarray(players))
    players = [players];

  foreach(player in players)
  dangernotifyplayer(player, _id_1022173EA86A7090, _id_334D3B08AEF373D4);
}

dangernotifyplayer(player, _id_1022173EA86A7090, _id_334D3B08AEF373D4) {
  _id_6841D14D64F8B70F = 0;
  _id_7805DB19F72B3753 = undefined;

  switch (_id_1022173EA86A7090) {
    case "toma_strike":
      _id_6841D14D64F8B70F = 1;
      break;
    case "precision_airstrike":
      _id_6841D14D64F8B70F = 2;
      break;
    case "gulag_closed":
      _id_6841D14D64F8B70F = 3;
      break;
    case "cash_deploy_closed":
      _id_6841D14D64F8B70F = 4;
      break;
    case "respawn_disabled":
      _id_6841D14D64F8B70F = 5;
      break;
    case "missiles_incoming":
      _id_6841D14D64F8B70F = 6;
      break;
    case "enemy_bounty":
      _id_6841D14D64F8B70F = 7;
      break;
    case "friendly_bounty":
      _id_6841D14D64F8B70F = 8;
      break;
    case "self_bounty":
      _id_6841D14D64F8B70F = 9;
      break;
    case "completed_bounty":
      _id_6841D14D64F8B70F = 10;
      break;
    case "missile_silo":
      _id_6841D14D64F8B70F = 11;
      _id_7805DB19F72B3753 = "dx_br_bds5_revl_wzan_slmn";
      break;
    default:
      _id_6841D14D64F8B70F = 0;
      break;
  }

  scripts\cp_mp\utility\killstreak_utility::_id_7585EEDA84603D89(player, _id_1022173EA86A7090, _id_7805DB19F72B3753);

  if(_id_6841D14D64F8B70F > 0) {
    player setclientomnvar("ui_br_danger_warning", _id_6841D14D64F8B70F);
    dangernotifyresetforplayer(player, _id_334D3B08AEF373D4);
  }
}

dangernotifyresetforplayer(player, _id_334D3B08AEF373D4) {
  playerid = player getxuid();

  if(!isDefined(_id_334D3B08AEF373D4))
    _id_334D3B08AEF373D4 = 4;

  level notify("danger_notify_start_" + playerid);
  level thread watchdangerresetaction(player, playerid, "death_or_disconnect");
  level thread watchdangerresetaction(player, playerid, undefined, _id_334D3B08AEF373D4);
}

watchdangerresetaction(player, playerid, action, timeout) {
  level endon("danger_notify_start_" + playerid);
  level endon("danger_notify_finished_" + playerid);
  level endon("game_ended");

  if(isDefined(action))
    player waittill(action);
  else if(isDefined(timeout))
    wait(timeout);

  if(isDefined(player))
    player setclientomnvar("ui_br_danger_warning", 0);

  level notify("danger_notify_finished_" + playerid);
}
/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\advanced_supply_drop.gsc
*********************************************************/

advanced_supply_drop_marker_used(grenade) {
  player = self;
  player endon("disconnect");
  grenade endon("explode_end");
  grenade thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  player thread advanced_supply_drop_refund_on_death(grenade);
  grenade waittill("explode", position);
  player notify("advanced_supply_drop_finished");
  thread advanced_supply_drop_marker_sfx(position);

  if(scripts\mp\outofbounds::ispointinoutofbounds(position)) {
    if(isDefined(grenade))
      grenade delete();

    if(isDefined(player.super))
      player scripts\mp\supers::superusefinished(1);

    return;
  }

  _id_17B727CD5881EFD8 = _id_4D5A55FCA0ED1835::getdropbagspawntypeenum(0, 0, 1, 0, 0, 0);
  player _id_4D5A55FCA0ED1835::spawndropbagatposition(position, _id_17B727CD5881EFD8);

  if(isDefined(player.super))
    player scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
}

_id_F3E74468F0E5F521(grenade) {
  player = self;
  player endon("disconnect");
  grenade endon("explode_end");
  grenade thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  player thread advanced_supply_drop_refund_on_death(grenade);

  if(isDefined(level._id_E3CCF0898A949BEC))
    level thread _id_22740C19D22B8B6E(player, grenade);

  grenade waittill("explode", position);
  player notify("advanced_supply_drop_finished");
  thread advanced_supply_drop_marker_sfx(position);

  if(scripts\mp\outofbounds::ispointinoutofbounds(position)) {
    if(isDefined(grenade))
      grenade delete();

    if(isDefined(player.super))
      player scripts\mp\supers::superusefinished(1);

    return;
  }

  spawnpoint = spawnStruct();
  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
  groundorigin = scripts\engine\utility::drop_to_ground(position, 10000, -20000, undefined, _id_FBCABD62B8F66EB8);
  spawnpoint.origin = groundorigin + (0, 0, 50000);
  vehicle = undefined;

  if(isDefined(vehicle)) {
    _id_799D521F485A1701::_id_020B77FBF1AF1A5D(vehicle, player.team, 1);
    level thread _id_799D521F485A1701::truck_airdrop(vehicle, groundorigin, vehicle.angles, 1);
  }

  if(isDefined(player.super))
    player scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
}

_id_22740C19D22B8B6E(player, grenade) {
  _id_A369F87F8A7A9868 = player.team;
  level._id_E3CCF0898A949BEC[_id_A369F87F8A7A9868] = 1;
  scripts\engine\utility::waittill_any_ents(player, "disconnect", grenade, "explode_end", grenade, "explode", grenade, "death");
  level._id_E3CCF0898A949BEC[_id_A369F87F8A7A9868] = undefined;
}

advanced_supply_drop_refund_on_death(grenade) {
  player = self;
  player endon("disconnect");
  player endon("advanced_supply_drop_finished");
  grenade waittill("death");
  waitframe();

  if(isDefined(player.super))
    player scripts\mp\supers::superusefinished(1);
}

advanced_supply_drop_marker_sfx(position) {
  _id_0BA3396E2B7597B2 = spawn("script_origin", position);
  _id_0BA3396E2B7597B2 playLoopSound("smoke_carepackage_smoke_lp");
  wait 21;
  _id_0BA3396E2B7597B2 playSound("smoke_canister_tail_dissipate");
  _id_0BA3396E2B7597B2 stoploopsound("smoke_carepackage_smoke_lp");
  wait 5;
  _id_0BA3396E2B7597B2 delete();
}
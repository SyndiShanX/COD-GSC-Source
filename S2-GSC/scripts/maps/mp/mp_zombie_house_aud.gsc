/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_house_aud.gsc
***************************************************/

main() {
  _id_0367::_id_8E3E("house");
  _id_7BBA();
  thread _id_526E();
}

_id_7BBA() {
  _id_0378::snd_register_message("player_connect_map", ::_id_7248);
  _id_0378::snd_register_message("player_spawned", ::_id_7330);
  _id_0378::snd_register_message("wave_begin", ::_id_A979);
  _id_0378::snd_register_message("wave_end", ::_id_A97A);
  _id_0378::snd_register_message("enter_last_stand", ::_id_37B4);
  _id_0378::snd_register_message("revive", ::_id_7E51);
  _id_0378::snd_register_message("death", ::death);
  _id_0378::snd_register_message("end_respawn", ::_id_36A1);
  _id_0378::snd_register_message("end_joined_spectators", ::_id_3689);
  _id_0378::snd_register_message("door_open", ::door_open);
  _id_0378::snd_register_message("door_close", ::_id_3257);
  _id_0378::snd_register_message("ee_complete", ::_id_3577);
  _id_0378::snd_register_message("ee_update", ::_id_3598);
  _id_0378::snd_register_message("ee_piano_use", ::_id_358B);
}

_id_526E() {}

_id_7248() {}

_id_7330() {
  _id_0366::_id_AB0D();
  self setclienttriggeraudiozone("int_house_downstairs");
  self clientaddsoundsubmix("house_global", 0.25);
  _id_0366::snd_zmb_set_plr_vox_scare_count_max(1);
}

_id_A979() {}

_id_A97A() {}

_id_37B4() {}

_id_7E51() {}

death() {
  var_0 = 5.0;
  _id_0366::_id_8E32(var_0);
}

_id_36A1() {}

_id_3689() {}

door_open() {}

_id_3257() {
  level._id_120E = _id_0380::_id_2889("training_house_door_close", undefined, self.origin);
  _id_0378::_id_8D14(level._id_120E);
}

_id_3577() {
  _id_0380::_id_2889("house_ee_door_open", undefined, self.origin);
}

_id_3598() {
  _id_0380::_id_2889("training_crow_caw", undefined, self.origin);
}

_id_358B(var_0, var_1) {
  if(var_1 == 1) {
    _id_0380::_id_2889("zmb_piano_success", undefined, var_0);
  } else {
    _id_0380::_id_2889("zmb_piano_fail", undefined, var_0);
  }
}
/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4e62208288203484.gsc
***********************************************/

_id_9DEA44768C803C6C() {
  level.quests._id_A8A2B21955B0B49B = [];
  scripts\engine\scriptable::scriptable_addusedcallback(::_id_91F2C11FA22708C6);
  scripts\engine\scriptable::scriptable_adddamagedcallback(::_id_26B79785E70AAD4E);
  level.quests._id_A8A2B21955B0B49B["mgl_quests_interactable_laptop_sequence"] = "laptop_interaction";
  level.quests._id_A8A2B21955B0B49B["mgl_quests_interactable_button"] = "button_interaction";
  level.quests._id_A8A2B21955B0B49B["mgl_quests_destructible"] = "destructible_damage";
  level.quests._id_A8A2B21955B0B49B["mgl_snowman_large"] = "snowman_damage";
  level.quests._id_A8A2B21955B0B49B["mgl_quests_drone"] = "drone_damage";
  level.quests._id_A8A2B21955B0B49B["mgl_quests_destructible_meteor"] = "meteor_damage";
}

_id_91F2C11FA22708C6(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  _id_1C2D55EC04D979E7 = spawnStruct();
  _id_1C2D55EC04D979E7.instance = instance;
  _id_1C2D55EC04D979E7.part = part;
  _id_1C2D55EC04D979E7.state = state;
  _id_1C2D55EC04D979E7.player = player;
  _id_1C2D55EC04D979E7._id_A5B2C541413AA895 = _id_A5B2C541413AA895;
  _id_1C2D55EC04D979E7._id_CC38472E36BE1B61 = _id_CC38472E36BE1B61;

  if(isDefined(level.quests._id_A8A2B21955B0B49B[instance.type]))
    level scripts\engine\utility::send_notify(level.quests._id_A8A2B21955B0B49B[instance.type], _id_1C2D55EC04D979E7);
}

_id_26B79785E70AAD4E(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(einflictor.classname == "script_vehicle" && smeansofdeath == "MOD_CRUSH" && isDefined(einflictor._id_628A2EBA2E3D4AF4))
    eattacker = einflictor._id_628A2EBA2E3D4AF4;

  damagedata = spawnStruct();
  damagedata.einflictor = einflictor;
  damagedata.eattacker = eattacker;
  damagedata.instance = instance;
  damagedata.idamage = idamage;
  damagedata.idflags = idflags;
  damagedata.smeansofdeath = smeansofdeath;
  damagedata.objweapon = objweapon;
  damagedata.vdir = vdir;
  damagedata.shitloc = shitloc;
  damagedata.modelindex = modelindex;
  damagedata.partname = partname;

  if(isDefined(level.quests._id_A8A2B21955B0B49B[instance.type]))
    eattacker scripts\engine\utility::send_notify(level.quests._id_A8A2B21955B0B49B[instance.type], damagedata);

  waitframe();
  _id_88CF5D42344516FF = instance getscriptablepartstate("health");

  if(isDefined(_id_88CF5D42344516FF) && _id_88CF5D42344516FF == "broken")
    level scripts\engine\utility::send_notify("item_destruction", damagedata);
}
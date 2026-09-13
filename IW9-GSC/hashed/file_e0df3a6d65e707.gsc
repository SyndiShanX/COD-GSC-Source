/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_e0df3a6d65e707.gsc
***********************************************/

main() {
  _id_71332A5B74214116::registerinteraction("interact_armorsatchel", ::_id_7BF49B03AA95DDEA, ::_id_B3C237B9F09304F6, ::_id_4D53102050B02DE5);
}

_id_7BF49B03AA95DDEA(interaction, player) {
  if(player _id_531CB1BE084314F7::hasplatepouch())
    return &"COOP_GAME_PLAY/ALREADY_HAVE_ARMOR_SATCHEL";
  else
    return &"COOP_GAME_PLAY/ARMOR_SATCHEL";
}

_id_B3C237B9F09304F6(interaction, player) {
  scripts\cp\loot_system::_id_46A2B7D2AD2BDC13(interaction, player);

  if(istrue(level._id_B17F3DC7C65B1860))
    _id_71332A5B74214116::remove_from_current_interaction_list(interaction);
}

_id_4D53102050B02DE5(_id_16037153C1704C7E) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_16037153C1704C7E.size; _id_AC0E594AC96AA3A8++)
    _id_16037153C1704C7E[_id_AC0E594AC96AA3A8]._id_9C791A7A7FC6C7B5 = "armor_satchel";
}
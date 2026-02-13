/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1820.gsc
*************************************************/

zombie_complete_objective() {
  if(isDefined(level._id_3BE9._id_0F51) && isDefined(level._id_3BE9._id_0F51._id_3BE5)) {
    switch (level._id_3BE9._id_0F51._id_3BE5) {
      case "holdout":
        _id_0986::complete_objective();
        break;
      case "orb_follow":
        _id_0988::complete_objective();
        break;
      case "domination":
        _id_0984::complete_objective();
        break;
      case "soul_capture":
        _id_0989::complete_objective();
        break;
      case "assault":
        scripts\cp\zombies\objective_assault::complete_objective();
        break;
      default:
        _id_0987::_id_A871(level._id_3BE9._id_0F51, 1);
        break;
    }
  }
}
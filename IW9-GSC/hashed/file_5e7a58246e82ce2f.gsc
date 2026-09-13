/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5e7a58246e82ce2f.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("mp_forsaken_gw_gametype_cs")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("mp_forsaken_gw_gametype_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "mp_forsaken_gw_gametype_cs");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "mp_forsaken_gw_gametype_cs");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "mp_forsaken_gw_gametype_cs");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5164.4, 3858.57, 400.52), (0, 289, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31655.1, -2186.81, 287.64), (0, 189, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5227.08, 3878.94, 399.02), (0, 289, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31664.3, -2252.08, 288.91), (0, 189, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31637.9, -2120.69, 287.74), (0, 189, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5102.28, 3830.11, 401.45), (0, 289, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5047.54, 3810.19, 402.71), (0, 289, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31627.8, -2063.32, 288.48), (0, 189, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5144.03, 3921.29, 406.11), (0, 289, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5206.74, 3941.77, 404.36), (0, 289, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5081.87, 3892.81, 407.31), (0, 289, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5027.02, 3872.95, 408.79), (0, 289, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31720.4, -2177.65, 288.97), (0, 189, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31729.7, -2242.95, 288.88), (0, 189, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31703.2, -2111.48, 288.58), (0, 189, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5123.55, 3983.96, 411.83), (0, 289, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31693.1, -2054.02, 289.07), (0, 189, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31785.7, -2168.36, 288.97), (0, 189, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31794.9, -2233.71, 288.88), (0, 189, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31768.6, -2102.27, 288.97), (0, 189, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31758.5, -2044.81, 289.17), (0, 189, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31849.7, -2152.36, 288.93), (0, 189, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31858.9, -2217.71, 288.81), (0, 189, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31832.6, -2086.27, 288.96), (0, 189, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31822.5, -2028.81, 288.97), (0, 189, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31596.4, -1886.78, 287.64), (0, 179, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31594.1, -1952.65, 288.91), (0, 179, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31590.9, -1818.67, 287.74), (0, 179, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31590.9, -1760.42, 288.48), (0, 179, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31662.3, -1889.09, 288.97), (0, 179, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31660.1, -1955.02, 288.88), (0, 179, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31656.8, -1820.94, 288.58), (0, 179, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31656.9, -1762.6, 289.07), (0, 179, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31728.2, -1891.28, 288.97), (0, 179, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31725.9, -1957.24, 288.88), (0, 179, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31722.8, -1823.23, 288.97), (0, 179, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31722.9, -1764.89, 289.17), (0, 179, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31794, -1886.64, 288.93), (0, 179, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31791.7, -1952.6, 288.81), (0, 179, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31788.6, -1818.59, 288.96), (0, 179, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (31788.7, -1760.24, 288.97), (0, 179, 0), "mp_ctf_spawn_allies_CS", undefined, "mp_ctf_spawn_allies_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5186.32, 4004.36, 409.8), (0, 289, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5061.45, 3955.61, 413.27), (0, 289, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5006.59, 3935.75, 414.97), (0, 289, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5096.69, 4044.21, 417.73), (0, 289, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5159.46, 4064.6, 415.5), (0, 289, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5034.59, 4015.86, 419.39), (0, 289, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (4979.72, 3995.99, 421.3), (0, 289, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7586.25, 6780.8, 230.08), (0, 334, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7616.17, 6839.53, 229.9), (0, 334, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7562.45, 6716.75, 230.53), (0, 334, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7537.83, 6663.96, 230.77), (0, 334, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7527.5, 6810.75, 228.12), (0, 334, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7557.36, 6869.57, 227.98), (0, 334, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7503.68, 6746.66, 228.48), (0, 334, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7478.94, 6693.83, 228.66), (0, 334, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7468.7, 6840.58, 226.62), (0, 334, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7498.66, 6899.39, 226.53), (0, 334, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7444.83, 6776.62, 226.87), (0, 334, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7420.09, 6723.79, 227), (0, 334, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7407.1, 6864.19, 225.64), (0, 334, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7437.07, 6922.99, 225.59), (0, 334, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7383.24, 6800.23, 225.79), (0, 334, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7358.49, 6747.39, 225.86), (0, 334, 0), "mp_ctf_spawn_axis_CS", undefined, "mp_ctf_spawn_axis_CS");
  s = scripts\common\create_script_utility::s();
  s.height = 144;
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (10458.7, 6055.3, 303.92), undefined, "ctf_flag_axis_CS", undefined, "ctf_flag_axis_CS", undefined, undefined, undefined, undefined, 64);
  s = scripts\common\create_script_utility::s();
  s.height = 144;
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (24166.6, 2856.38, 184), undefined, "ctf_flag_allies_CS", undefined, "ctf_flag_allies_CS", undefined, undefined, undefined, undefined, 64);
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}
main()
{
	maps\mp\_load::main();
	maps\mp\_compass::setupMiniMap("compass_map_mp_cairo");
	// If the team nationalites change in this file,
	// you must update the team nationality in the level's csc file as well!
	maps\mp\gametypes\_teamset_cubans::level_init();
}

init()
{
	self setClientDvar( "r_exposurevalue", "2" );
}
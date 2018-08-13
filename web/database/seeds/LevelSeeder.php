<?php

use Illuminate\Database\Seeder;

class LevelSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
    	$data = array(
		    array('level'=> 1, 'exp'=> 0),
		    array('level'=> 2, 'exp'=> 1500),
		    array('level'=> 3, 'exp'=> 1800),
		    array('level'=> 4, 'exp'=> 2160),
		    array('level'=> 5, 'exp'=> 2592),
		    array('level'=> 6, 'exp'=> 3110),
		    array('level'=> 7, 'exp'=> 3732),
		    array('level'=> 8, 'exp'=> 4478),
		    array('level'=> 9, 'exp'=> 5374),
		    array('level'=> 10, 'exp'=> 6449),
		    array('level'=> 11, 'exp'=> 7734),
		    array('level'=> 12, 'exp'=> 9287),
		    array('level'=> 13, 'exp'=> 11145),
		    array('level'=> 14, 'exp'=> 13374),
		    array('level'=> 15, 'exp'=> 16048),
		    array('level'=> 16, 'exp'=> 19258),
		    array('level'=> 17, 'exp'=> 23110),
		    array('level'=> 18, 'exp'=> 27732),
		    array('level'=> 19, 'exp'=> 33279),
		    array('level'=> 20, 'exp'=> 39934),
		    array('level'=> 21, 'exp'=> 47921),
		    array('level'=> 22, 'exp'=> 57506),
		    array('level'=> 23, 'exp'=> 69007),
		    array('level'=> 24, 'exp'=> 82809),
		    array('level'=> 25, 'exp'=> 99371),
		    array('level'=> 26, 'exp'=> 119245),
		    array('level'=> 27, 'exp'=> 143094),
		    array('level'=> 28, 'exp'=> 171413),
		    array('level'=> 29, 'exp'=> 206055),
		    array('level'=> 30, 'exp'=> 247266),
		    array('level'=> 31, 'exp'=> 296720),
		    array('level'=> 32, 'exp'=> 356064),
		    array('level'=> 33, 'exp'=> 427477),
		    array('level'=> 34, 'exp'=> 512732),
		    array('level'=> 35, 'exp'=> 615279),
		    array('level'=> 36, 'exp'=> 738335),
		    array('level'=> 37, 'exp'=> 886002),
		    array('level'=> 38, 'exp'=> 1063202),
		    array('level'=> 39, 'exp'=> 1275843),
		    array('level'=> 40, 'exp'=> 1531012),
		    array('level'=> 41, 'exp'=> 1837214),
		    array('level'=> 42, 'exp'=> 2204657),
		    array('level'=> 43, 'exp'=> 2645588),
		    array('level'=> 44, 'exp'=> 3174706),
		    array('level'=> 45, 'exp'=> 3809647),
		    array('level'=> 46, 'exp'=> 4571577),
		    array('level'=> 47, 'exp'=> 5485892),
		    array('level'=> 48, 'exp'=> 6583071),
		    array('level'=> 49, 'exp'=> 7899685),
		    array('level'=> 50, 'exp'=> 9479623),
		    array('level'=> 51, 'exp'=> 11375547),
		    array('level'=> 52, 'exp'=> 13650657),
		    array('level'=> 53, 'exp'=> 16380788),
		    //...
		);
        DB::table('levels')->insert($data);
        
    }
}

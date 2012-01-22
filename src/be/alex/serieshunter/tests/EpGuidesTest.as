package be.alex.serieshunter.tests {
import be.alex.serieshunter.data.Episode;
import be.alex.serieshunter.data.Show;
import be.alex.serieshunter.util.EpGuide;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertTrue;

public class EpGuidesTest {

    [Test(async)]
    public function madMen():void {
        var epGuides = new EpGuide("http://epguides.com/madmen/")

        epGuides.getShow(AsyncUtil.asyncHandler(this, verifyMadMen))
    }

    private function verifyMadMen(series:Show):void {
        assertTrue(series.episodes.length > 0)

        var firstEpisode:Episode = series.episodes[0]

        assertEquals(1, firstEpisode.season)
        assertEquals(1, firstEpisode.number)
        assertEquals("Smoke Gets in Your Eyes", firstEpisode.name)

        var secondEpisode:Episode = series.episodes[1]

        assertEquals(1, secondEpisode.season)
        assertEquals(2, secondEpisode.number)
        assertEquals("Ladies Room", secondEpisode.name)
        assertEquals("Thu Jul 26 2007", secondEpisode.airDate.toDateString())

        var outOfTown:Episode = series.episodes.filter(function(item:Episode, index:int, array:Array) {
            return item.season == 3 && item.number == 1
        })[0]

        assertEquals("Out of Town", outOfTown.name)
    }
}
}

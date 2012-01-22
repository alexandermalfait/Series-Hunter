/**
 * Created by IntelliJ IDEA.
 * User: Alex
 * Date: 1/05/11
 * Time: 18:19
 * To change this template use File | Settings | File Templates.
 */
package be.alex.serieshunter.tests {
import be.alex.serieshunter.data.Episode;
import be.alex.serieshunter.data.Show;
import be.alex.serieshunter.util.EpisodeFinder;

import org.flexunit.asserts.assertEquals;

public class EpisodeFinderTest {

    [Test]
    public function house() {
        var house:Show = new Show()

        house.path = "D:\\episodes\\House";

        var episode:Episode = new Episode();

        episode.season = 7
        episode.number = 2

        house.episodes.push(episode)

        var finder:EpisodeFinder = new EpisodeFinder(house)

        finder.updateEpisodes()

        assertEquals("present", episode.status)
    }

    [Test]
    public function houseNotPresent() {
        var house:Show = new Show()

        house.path = "D:\\episodes\\House";

        var episode:Episode = new Episode();

        episode.season = 4
        episode.number = 2

        house.episodes.push(episode)

        var finder:EpisodeFinder = new EpisodeFinder(house)

        finder.updateEpisodes()

        assertEquals("wanted", episode.status)
    }
}
}

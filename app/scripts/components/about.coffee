React = require "react"
Reflux = require "reflux"
NavBarStore = require "../stores/navbarStore"
DateStore = require "../stores/dateStore"
DateActions = require "../actions/dateActions"

About = React.createClass
  mixins: [
    Reflux.connect NavBarStore, "navbarState"
    Reflux.connect DateStore, "date"
  ]

  render: ->
    aboutClass = "about"
    if @state.navbarState.open
      aboutClass = "about open"
    (
      <div className={aboutClass}>
        <div className="about__info">
          <h3 className="about__title">Harmonices Mundi</h3>
          <p>In 1619 Thomas Kepler published <i>Harmonices Mundi</i>, or <a href="https://archive.org/details/ioanniskepplerih00kepl" className="about__link">The Harmony of the World</a>, his exploration of harmony and congruence in geometrical forms and physical phenomena. In it, he traces the soundtrack of the known celestial world, by ascribing a system of notes and interval ratios to the each of the planets on their orbital paths. This “music of the spheres” is a constant hum of sorts, a result of the motion and orbital resonance of each planet based on its revolution around the sun. The theory was based upon an idea previously proposed by Pythagorus and Ptolemy, to which Kepler adds his third law of planetary motion which introduces elliptical orbits. As with many of Kepler’s theories, this contains not only scientific and mathematical research, but also artistic and religious undertones.
          </p>

          <p>For this project I've constructed a model of the univerise as it was understood to Kepler and I then used his calculataions to approximate
          plantary positions on any given date. It's surprising, if not scary, how accurate his measurements have proved to be. I also used his concepts for the pitches and voicing heard in the "music of the spheres" as explained through out <i>Harmonicies Mundi</i>.
          I've greatly increased the speed of playback (as apposed to "real time", one earth revolution per year) to more easily hear the changing pitches as the planets rotate in their obital path. Jupiter and Saturn's pitches are very low - so a nice pair of headphones or speakers will give a more complete representation.</p>

          <p>Ideas, information and modern translations used for this site were informed by the excellent books <a href="http://www.amazon.com/Harmonies-Heaven-Earth-Mysticism-Avant-Garde/dp/0892815000" className="about__link">Harmonies of Heaven and Earth: Mysticism in Music from Antiquity to the Avant-Garde</a> and <a href="http://www.amazon.com/gp/product/0892812656/ref=pd_lpo_sbs_dp_ss_1?pf_rd_p=1944687642&pf_rd_s=lpo-top-stripe-1&pf_rd_t=201&pf_rd_i=0892815000&pf_rd_m=ATVPDKIKX0DER&pf_rd_r=10QEGCZ9BYNA5GH5YDZQ" className="about__link">The Harmony of the Spheres: The Pythagorean Tradition in Music</a> by Joscelyn Godwin. You can read some of his thoughts on this topic in the article <a className="about__link" href="http://hermetic.com/godwin/kepler-and-kircher-on-the-harmony-of-the-spheres.html">Kepler and Kircher on the Harmony of the Spheres</a>, in which he includes Kepler's diagram of the musical notation of each planet's pitches.
          </p>
          <p>Select your birthday or anniversay, kick back and listen to some other-worldly dissonance. Enjoy!</p>
          <p><a className="about__link" href="http://jeffreypierce.net">built by jeffrey</a> • <a className="about__link" href="http://github.com/jeffreypierce/kepler">source on github</a></p>
        </div>
      </div>

    )

module.exports = About

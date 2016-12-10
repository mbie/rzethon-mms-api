require 'time'

class PlanetLocator
  $orbitals = {
    :mercury => {
      :n => [48.3313, 3.24587E-5],
      :i => [7.0047, 5.00E-8],
      :w => [29.1241, 1.01444E-5],
      :a => [0.387098, 0],
      :e => [0.205635, 5.59E-10],
      :m => [168.6562, 4.0923344368]
    },
    :venus => {
      :n => [76.6799, 2.46590E-5],
      :i => [3.3946, 2.75E-8],
      :w => [54.8910, 1.38374E-5],
      :a => [0.723330, 0],
      :e => [0.006773, 1.302E-9],
      :m => [48.0052, 1.6021302244]
    },
    :earth => {
      :n => [0.0, 0],
      :i => [0.0, 0],
      :w => [282.9404, 4.70935e-5],
      :a => [1.0, 0],
      :e => [0.016709, 1.151e-9],
      :m => [356.0470, 0.9856002585]
    },
    :mars => {
      :n => [49.5574, 2.11081e-5],
      :i => [1.8497, 1.78e-8],
      :w => [286.5016, 2.92961e-5],
      :a => [1.523688, 0],
      :e => [0.093405, 2.516e-9],
      :m => [18.6021, 0.5240207766]
    },
    :jupiter => {
      :n => [100.4542, 2.76854E-5],
      :i => [1.3030, 1.557E-7],
      :w => [273.8777, 1.64505E-5],
      :a => [5.20256, 0],
      :e => [0.048498, 4.469E-9],
      :m => [ 19.8950, 0.0830853001]
    },
    :saturn => {
      :n => [113.6634, 2.38980E-5],
      :i => [2.4886, 1.081E-7],
      :w => [339.3939, 2.97661E-5],
      :a => [9.55475, 0],
      :e => [0.055546, 9.499E-9],
      :m => [316.9670, 0.0334442282]
    },
    :uranus => {
      :n => [74.0005, 1.3978E-5],
      :i => [0.7733, 1.9E-8],
      :w => [96.6612, 3.0565E-5],
      :a => [19.18171, 1.55E-8],
      :e => [0.047318, 7.45E-9],
      :m => [142.5905, 0.011725806]
    },
    :neptune => {
      :n => [131.7806, 3.0173E-5],
      :i => [1.7700, 2.55E-7],
      :w => [272.8461, 6.027E-6],
      :a => [30.05826, 3.313E-8],
      :e => [0.008606, 2.15E-9],
      :m => [260.2471, 0.005995147]
    }
  }

  def coordinate_gen(planet, max_day)
    points = (0..max_day).collect do |d|
      self.position_by_date(planet, d, 0)
    end

    points.transpose
  end

  @planets = [:mercury, :venus, :earth, :mars, :jupiter, :saturn, :uranus, :neptune]
  #@orbits = Hash[@planets.collect do |planet|
    #count = 360.0 / $orbitals[planet][:m][1]
    #res = self.coordinate_gen(planet, count)
    #[planet, res]
  #end]


  def get_orbitals(planet, d)
    o = $orbitals[planet]
    [
      (o[:n][0] + o[:n][1] * d) * Math::PI / 180.0,
      (o[:i][0] + o[:i][1] * d) * Math::PI / 180.0,
      (o[:w][0] + o[:w][1] * d) * Math::PI / 180.0,
      o[:a][0] + o[:a][1] * d,
      (o[:e][0] + o[:e][1] * d) * Math::PI / 180.0,
      (o[:m][0] + o[:m][1] * d) * Math::PI / 180.0
    ]
  end

  def position_by_date(planet, date, offset=0)
      date = self.get_star_date(date)
      n,i,w,a,e,m = get_orbitals(planet,date)
      m += offset
      e2 = m + e * Math.sin(m) * (1.0 + e * Math.cos(m))

      xv = a * (Math.cos(e2) - e)
      yv = a * (Math.sqrt(1.0 - e*e) * Math.sin(e2))
      v = Math.atan2(yv, xv)
      r = Math.sqrt(xv*xv + yv*yv)

      xh = r * ( Math.cos(n) * Math.cos(v+w) - Math.sin(n) * Math.sin(v+w) * Math.cos(i))
      yh = r * ( Math.sin(n) * Math.cos(v+w) + Math.cos(n) * Math.sin(v+w) * Math.cos(i))
      zh = r * ( Math.sin(v+w) * Math.sin(i) )

      [xh, yh, zh]
  end

  def get_star_date(timestamp)
    timestamp = timestamp/1000
    date = Time.at(timestamp).to_datetime
    d = 367*date.year - 7 * ( date.year + (date.month+9)/12 ) / 4 + 275*date.month/9 + date.day - 730530
    d += date.hour/24.0 + date.minute/1440.0 + date.second/86400.0
    d
  end
end

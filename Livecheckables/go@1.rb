class GoAT1
  livecheck do
    url "https://golang.org/dl/"
    regex(/go(([0-9.]+)((beta|rc|alpha)[1-9])?)\.src/)
  end
end

from unittest import TestCase
from pomona import pomona


class TestExtension(TestCase):
    def test_1(self):
        p = pomona.Pomona()
        self.assertAlmostEqual(p.name, "Pomona")

# EOF

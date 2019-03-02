import std.stdio;
import std.math;
import std.algorithm;
import std.typecons;
import std.string;
import std.conv;
import std.regex;

version(prob00)
{
	void invoke()
	{
		writeln("16 Great Years of CodeWars!");
	}
}

version(prob01)
{
	void invoke()
	{
		int sold;
		readf!"%d\n"(sold);
		writeln(8 * sold - 95);
	}
}

version(prob02)
{
	void invoke()
	{
		double d;
		readf!"%f"(d);
		writeln(d * 28.3495);
	}
}

version(prob03)
{
	void invoke()
	{
		string name, planet;
		double weight, factor;
		readf!"%s %f %s %f\n"(name, weight, planet, factor);
		while (name != "END")
		{
			writeln("On ", planet, ", ", name, " would weigh ", weight * factor, " pounds.");
			readf!"%s %f %s %f\n"(name, weight, planet, factor);
			name.writeln;
		}
	}
}

version(prob04)
{
	void invoke()
	{
		double g = 9.80665;
		double pi = 3.14159265;
		alias rad = (double a) => (pi * a) / 180;
		double v, angle;
		readf!"%f\n%f\n"(v, angle);
		writeln(
			(v * v) * sin(2 * rad(angle)) / g
		);
	}
}

version(prob05)
{
	int computeSequence(int[] sequence, int i)
	{
		if (i < 3)
			return sequence[i];
		int ctr;
		auto seq = sequence;
		for (int j = 3; j <= i; ++j)
		{
			ctr = seq[j-1] + seq[j-2] + seq[j-3];
			seq ~= ctr;
		}
		return ctr;
	}
	unittest
	{
		int[] seq = [0, 1, 1];
		assert(seq.computeSequence(3) == 2);
		assert(seq.computeSequence(9) == 81);
		assert(seq.computeSequence(11) == 274);
		assert(seq.computeSequence(0) == 0);
	}
	void invoke()
	{
		int[] seq = [0, 1, 1];
		int i;
		readf!"%d\n"(i);
		while (i != -1)
		{
			writeln(
				seq.computeSequence(i)
			);
			readf!"%d\n"(i);
		}
	}
}


version(prob06)
{
	alias Point = Tuple!(double, "x", double, "y");
	double computeArea(Point A, Point B, Point C)
	{
		alias distance 	= (Point P0, Point P1) => ( sqrt( pow(P0.x - P1.x, 2) + pow(P0.y - P1.y, 2) ) );
		alias angle 	= (double a, double b, double c) => ( acos( ( pow(a, 2) + pow(b, 2) - pow(c, 2) ) / (2 * a * b) ) );
		alias area		= (double a, double b, double w) => ( (a * b * sin(w) ) / 2 );
		double a = distance(A, B);
		double b = distance(B, C);
		double c = distance(C, A);
		double w = angle(a, b, c);
		return area(a, b, w);
	}
	unittest
	{
		assert(computeArea(
			Point(3.1415, 2.7777),
			Point(-3.9123, 0.2133),
			Point(0.4324, -11.111)
		) == 45.5104);
	}
	void invoke()
	{
		double ax, ay, bx, by, cx, cy;
		readf!"%f %f %f %f %f %f\n"(ax, ay, bx, by, cx, cy);
		while (ax != 0.0 || ay != 0.0 || bx != 0.0 || by != 0.0 || cx != 0.0 || cy != 0.0)
		{
			writeln(computeArea(
				Point(ax, ay),
				Point(bx, by),
				Point(cx, cy)
			));
			readf!"%f %f %f %f %f %f\n"(ax, ay, bx, by, cx, cy); //3.1415 2.7777 -3.9123 0.2133 0.4324 -11.111
		}
	}
}

version(prob07)
{
	int computeHour(int minute)
	{
		int hour = cast(int)ceil(cast(double)minute / 5.0);
		int location = -hour;
		// normalize location
		if (location < 0)
			location += 12;
		if (location > 12)
			location -= 12;
		if (location == 0)
			location = 12;
		return location;
	}
	unittest
	{
		writeln("wad",computeHour(0));
		assert(computeHour(18) == 8);
		assert(computeHour(5) == 11);
		assert(computeHour(46) == 2);
		assert(computeHour(0) == 12);
	}
}

version(prob08)
{
	bool distinct(string s)
	{
		char[int] map;
		foreach(c; s)
		{
			map[c]++;
			if (map[c] > 1)
				return false;
		}
		return true;
	}
	unittest
	{
		assert("UNCOPYRIGHTABLE".distinct == true);
		assert("FLIPPER".distinct == false);
		assert("EXECUTABLE".distinct == false);
		assert("UNPROFITABLE".distinct == true);
		assert("QUESTIONABLY".distinct == true);
		assert("WINDOW".distinct == false);
		assert("TAMBOURINE".distinct == true);
	}
	void invoke()
	{
		string s = readln().stripRight;
		while (s != ".")
		{
			writeln(s,
				s.distinct ? " USES DISTINCT LETTERS" : " DOES NOT USE DISTINCT LETTERS"
			);
			s = readln().stripRight;
		}
	}
}

version(prob09)
{
	int countOnes(int n)
	{
		int sum;
		for(int i = 0; i <= n; ++i)
		{
			string s = i.text;
			sum += s.count!((a,b) => a == b)('1');
		}
		return sum;
	}
	unittest
	{
		assert( countOnes(13) == 6);
		assert( countOnes(1) == 1);
		assert( countOnes(999) == 300);
		assert( countOnes(23) == 13);
		assert( countOnes(1111) == 448);
		assert( countOnes(9997) == 4000);
		assert( countOnes(511) == 204);
	}
	void invoke()
	{
		int i;
		readf!"%d\n"(i);
		while (i != -1)
		{
			writeln(i.countOnes);
			readf!"%d\n"(i);
		}
	}
}

version(prob10)
{
	/*
	so, I think this works, by generating the potential weights by
	*/
	uint[] generatePossibleMatches(uint[] set)
	{
		uint[] set;
		foreach(pair; set.chunks(2))
		{
			double d = (pair[0] + pair[1]) / 4;
			uint differ = cast(uint)(d + 0.5); // round to nearest int
			set ~= pair[0] - differ;
			set ~= pair[1] - differ;
		}
		return set;
	}
	uint[] findMatchingSet(uint[] confirmed, uint[] potentials)
	{
		// we should have 10 weights
		// we need to generate all possible sets of 5
		
	}
}

version(prob11) // hacky as heck, some sort of ghetto linkedlist that isn't a linkedlist wowzers
{
	alias DelayedAdd = Tuple!(string, "add", int, "counter");
	string contradict(string s)
	{
		string poppin;
		int blankCounter = 0;
		DelayedAdd[] adders;
		foreach(i, c; s)
		{
			// we need 8 chars to check for " is not "
			bool locatedNegative = false;
			if (i+7 < s.length)
			{
				// construct string
				string sub = s[i..i+7];
				assert(sub.length == 7);
				if (sub == " is not")
				{
					blankCounter = 7; // skip 8 elements
					locatedNegative = true;
					// now add an adder
					adders ~= DelayedAdd(" is", 1);
				}
			}
			if (i+3 < s.length && !locatedNegative)
			{
				string sub = s[i..i+3];
				assert(sub.length == 3);
				if (sub == " is")
				{
					adders ~= DelayedAdd(" not", 3);
				}
			}
			if (blankCounter == 0)
				poppin ~= c;
			for (int j = 0; j < adders.length; ++j)
			{
				adders[j].counter--;
				if (adders[j].counter == 0)
				{
					poppin ~= adders[j].add;
				}
			}
			// now we decrement the blank counter
			if (blankCounter > 0)
				blankCounter--;
		}
		poppin.writeln;
		return poppin;
	}
	unittest
	{
		// This an argument.
		assert( contradict("This is not an argument.") == "This is an argument.");	
		assert( contradict("An argument is an intellectual process.") == "An argument is not an intellectual process.");
		assert( contradict("It is fair if you do not go.") == "It is not fair if you do not go.");
		assert( contradict("The ferris wheel is not working.") == "The ferris wheel is working.");
		assert( contradict("A butterfly is beautiful, but litter is not.") == "A butterfly is not beautiful, but litter is.");
		assert( contradict("A lady discerns that which is not elegant from that which is.") == "A lady discerns that which is elegant from that which is not.");
		assert( contradict("A lemur is a monkey and a grivet is a monkey but a chimp is not.") == "A lemur is not a monkey and a grivet is not a monkey but a chimp is.");
	}
}


version(prob12)
{
	bool morseCodePalindrome(string s)
	{
		string[char] map = [
			'a' : "*-",
			'b' : "-***",
			'c' : "-*-*",
			'd' : "-**",
			'e' : "*",
			'f' : "**-*",
			'g' : "--*",
			'h' : "****",
			'i' : "**",
			'j' : "*---",
			'k' : "-*-",
			'l' : "*-**",
			'm' : "--",
			'n' : "-*",
			'o' : "---",
			'p' : "*--*",
			'q' : "--*-",
			'r' : "*-*",
			's' : "***",
			't' : "-",
			'u' : "**-",
			'v' : "***-",
			'w' : "*--",
			'x' : "-**-",
			'y' : "-*--",
			'z' : "--**"
		];
		string toMorse(string t)
		{
			string u;
			foreach(c; t)
				u ~= map[c];
			return u;
		}
		string x = s.replaceAll(regex("[^a-zA-z]", "g"), "");
		string a = toMorse(x.toLower);
		char[] b = cast(char[])a.dup;
		b.reverse();
		// writeln(s, "\ta: ", a);
		// writeln(s, "\tb: ", b);
		if (cast(string)b == a)
			return true;
		return false;
	}
	unittest
	{
		assert(morseCodePalindrome("ELEGIZED") == true);
		assert(morseCodePalindrome("QUIRKILY") == true);
		assert(morseCodePalindrome("MERCURY") == false);
		assert(morseCodePalindrome("FACE A WINE") == true);
		assert(morseCodePalindrome("HAPPY DAY") == false);
		assert(morseCodePalindrome("FEVER REBEL") == true);
		assert(morseCodePalindrome("SOPRANOS") == true);
		assert(morseCodePalindrome("EMIT OLD UFO TIME") == true);
		assert(morseCodePalindrome("PROTEIN POWDER") == false);
		assert(morseCodePalindrome("ANNEXING") == true);
		assert(morseCodePalindrome("ENJOIN") == true);
	}
	void invoke()
	{
		string s = readln().stripRight;
		while (s != ".")
		{
			bool mcp = morseCodePalindrome(s);
			writeln(s, " is ", mcp ? "" : "*not* ", "a MCP");
			s = readln().stripRight;
		}
	}
}

version(prob13)
{
	// ugh, codewars not like me
	
}









version(unittest)
{
	// nothing 
}
else
{
	void main()
	{
		invoke();
	}
}

vim.g.projectionist_heuristics = {
	["lib/*.dart"] = {
		["lib/src/*.dart"] = {
			alternate = "test/{}_test.dart",
			type = "source",
		},
		["test/*_test.dart"] = {
			alternate = { "lib/src/{}.dart" },
			type = "test",
			template = {
				"import 'package:flutter_test/flutter_test.dart';",
				"import 'package:mocktail/mocktail.dart';",
				"",
				"void main() async {",
				"  group('{basename|camelcase|capitalize}', () {",
				"    // TODO:",
				"    test('', (){open}{close})",
				"  });",
				"}",
			},
		},
		["lib/util/*.dart"] = {
			alternate = "test/{}_test.dart",
			type = "source",
		},
	},
}

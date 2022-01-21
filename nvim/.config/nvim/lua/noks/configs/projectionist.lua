 vim.g.projectionist_heuristics = {
    ["lib/*.dart"] = {
      ["lib/src/*.dart"] = {
        alternate = "test/{}_test.dart",
        type = "source",
      },
      ["test/*_test.dart"] = {
        alternate = {"lib/src/{}.dart"},
        type = "test",
        template = {
          "import 'package:flutter_test/flutter_test.dart';",
          "import 'package:mockito/mockito.dart';",
          "",
          "void main() async {",
          "  group('{basename|camelcase|capitalize}', () {",
          "    // TODO:",
          "    test('', (){})",
          "  });",
          "}",
        },

      },
      ["lib/util/*.dart"] = {
        alternate = "test/{}_test.dart",
        type = "source",
      },
      ["lib/view_models/*_view_model.dart"] = {
        alternate = { "lib/screens/{}.dart", "lib/widgets/{}.dart" },
        type = "model",
        template = { "class {camelcase|capitalize}ViewModel extends BaseViewModel {", "}" },
      },
      ["test/view_models/*_view_model_test.dart"] = {
        alternate = "lib/view_models/{}_view_model.dart",
        type = "test",
      },
    },
  }


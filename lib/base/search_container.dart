import 'package:flutter/material.dart';
import 'package:iut_eats/utils/colors.dart';
import '../utils/dimensions.dart';

class AppSearchContainer extends StatelessWidget {
  final Function(String) onSearch;
  final TextEditingController searchController;

  const AppSearchContainer({
    super.key,
    required this.onSearch,
    required this.searchController
  });

  void _performSearch() {
    if (searchController.text.isNotEmpty) {
      onSearch(searchController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // unfocus the keyboard if tapped outside
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          width: Dimensions.screenWidth/3,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey)
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: _performSearch,
                child: Icon(
                  Icons.search_outlined,
                  color: AppColors.mainColor,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      _performSearch();
                    },
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
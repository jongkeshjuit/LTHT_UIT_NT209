#include <bits/stdc++.h>

using namespace std;

// Các hàm thông báo kết quả
void success_1() {
    cout << "Congrats! You found the hard-coded secret, good job :)." << endl;
}

void success_2() {
    cout << "Congrats! You found a secret pair of numbers :)." << endl;
}

void success_3() {
    cout << "Congrats! You found your own username/password pair :)." << endl;
}

void failed_with_hint(const string &hint) {
    cout << "Nice try but that is not the answer." << endl;
    cout << "Hint: The correct input is \"" << hint << "\"." << endl;
}

// Option 1. Hàm xử lý "hard-coded password"
void hardCode() {
    string input;
    const string correct_password = "New one in, old one out";

    cout << "Enter the hard-coded password (option 1): ";
    getline(cin, input); // Đọc cả dòng để nhận chuỗi có khoảng trắng
    cout << "Your input hard-coded password: " << input << endl;

    if (input == correct_password) {
        success_1();
    } else {
        failed_with_hint(correct_password);
    }
}

// Option 2. Hàm xử lý "pair of numbers"
int funny_func(int a1, int a2) {
    return a2 + a1 - 2 * a1;
}

void otherhardCode() {
    int num1, num2;
    const int correct_num1 = 8;
    const int correct_num2 = 1; // Theo hàm funny_func logic là: a2 = a1 - 2 * a1

    cout << "Enter your 2 numbers (separated by space) (option 2): ";
    cin >> num1 >> num2;
    cout << "Your input: " << num1 << " " << num2 << endl;

    if (num1 == correct_num1 && num2 == correct_num2) {
        success_2();
    } else {
        cout << "Nice try but that is not the answer." << endl;
        cout << "Hint: The correct input is \"" << correct_num1 << " " << correct_num2 << "\"." << endl;
    }
}

// Option 3. Hàm xử lý "username/password"
void userpass() {
    char username[10];
    char v5[10] = {0}; // Đảm bảo v5 được khởi tạo
    char v6[10] = {0}; // Đảm bảo v6 được khởi tạo

    // Nhập tên người dùng
    cout << "Enter your username (exactly 9 characters): ";
    cin >> username;

    if (strlen(username) != 9) {
        cout << "Username must be exactly 9 characters!" << endl;
        return;
    }

    // Giá trị cố định cho các phần tử cuối
    const char fixedValues[] = {95, 125, 118, 93, 93};

    // Tạo chuỗi v5 theo logic
    for (int i = 0; i < 9; ++i) {
        if (i > 1) {
            if (i > 3) {
                switch (i) {
                    case 4: v5[i] = fixedValues[0]; break;
                    case 5: v5[i] = fixedValues[1]; break;
                    case 6: v5[i] = fixedValues[2]; break;
                    case 7: v5[i] = fixedValues[3]; break;
                    case 8: v5[i] = fixedValues[4]; break;
                }
            } else {
                v5[i] = username[i + 5];
            }
        } else {
            v5[i] = username[i + 2];
        }
    }

    // Tính toán chuỗi v6
    for (int i = 0; i < 9; ++i) {
        v6[i] = (char)((username[i] + v5[i]) / 2);
    }
    v6[9] = '\0'; // Kết thúc chuỗi v6

    cout << "Calculated v5: " << v5 << endl;
    cout << "Calculated v6: " << v6 << endl;

    // Giá trị v6 dự kiến tính theo username và giá trị cố định
    string expected_password = "expected_password"; // Đổi giá trị này thành giá trị dự kiến

    if (strcmp(v6, expected_password.c_str()) == 0) {
        success_3();
    } else {
        failed_with_hint(expected_password);
    }
    success_3();
    cout << "The correct answer is v6: " << v6 << endl;
}

int main() {
    int choice;
    while(1)
    {
        cout << "\n\nSupported authentication methods:" << endl;
        cout << "-1. Exit the program" << endl;
        cout << "1. Hard-coded password" << endl;
        cout << "2. A pair of 2 numbers" << endl;
        cout << "3. Username/password" << endl;
        cout << "Enter your choice: ";
        cin >> choice;
        cin.ignore(); // Bỏ ký tự xuống dòng thừa từ cin
        if(choice == -1)
            break;
        if(choice == 1)
            hardCode();
        if(choice == 2)
            otherhardCode();
        if(choice == 3)
            userpass();
        else
            cout << "Invalid authentication method. Try again." << endl;
    }
    return 0;
}

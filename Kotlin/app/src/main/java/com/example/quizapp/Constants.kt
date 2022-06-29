package com.example.quizapp

object Constants{

    const val USER_NAME: String = "user_name"
    const val TOTAL_QUESTIONS: String = "total_question"
    const val CORRECT_ANSWER: String = "correct_answers"

    fun getQuestions(): ArrayList<Question>{
        val questionList = ArrayList<Question>()

        val ques1 = Question(
            1,
            "Khái niệm “đường bộ” được hiểu như thế nào là đúng? “Đường bộ” gồm:",
            "1. Đường bộ, cầu đường bộ.",
            "2. Hầm đường bộ, bến phà đường bộ.",
            "3. Các công trình phụ trợ khác.",
            "4. 2 Đáp án đầu tiên",
            4
        )
        questionList.add(ques1)

        val ques2 = Question(
            2,
            "Khái niệm “đường phố” được hiểu như thế nào là đúng?",
            "1. Đường phố là đường đô thị, gồm lòng đường và hè phố",
            "2. Đường phố là đường bộ ngoài đô thị có lòng đường đủ rộng cho các phương tiện giao thông qua lại",
            "3. Cả 2 ý nêu trên",
            "4. Không đáp án nào đúng",
            3
        )
        questionList.add(ques2)

        val ques3 = Question(
            3,
            "Dải phân cách trên đường bộ có những loại nào?",
            "1.Loại cố định",
            "2.Loại di động",
            "3. Cả 2 đáp án trên",
            "4. Không đáp án nào đúng",
            3
        )
        questionList.add(ques3)

        val ques4 = Question(
            4,
            "Phương tiện tham gia giao thông đường bộ” gồm những loại nào?",
            "1.\tPhương tiện giao thông cơ giới đường bộ.",
            "2.\tPhương tiện giao thông thô sơ đường bộ ",
            "3. Xe máy chuyên dùng",
            "4. Tất cả đều đúng",
            4
        )
        questionList.add(ques4)

        val ques5 = Question(
            5,
            "Người điều khiển xe mô tô, xe gắn máy trên đường mà trong khí thở có nồng độ cồn vượt quá bao nhiêu thì bị cấm ?",
            "1. Nồng độ cồn vượt quá 0.25 miligam/1 lit khí thở.",
            "2. Nồng độ cồn vượt quá 0.20 miligam/1 lit khí thở",
            "3. Nồng độ cồn vượt quá 0.15 miligam/1 lit khí thở.",
            "4. Nồng độ cồn vượt quá 0.22.5 miligam/1 lit khí thở.",
            1
        )
        questionList.add(ques5)

        val ques6 = Question(
            6,
            "Bảo đảm trật tự an toàn giao thông đường bộ là trách nhiệm của ai?",
            "1. Là trách nhiệm của ngành giao thông vận tải và ngành công an",
            "2. Là trách nhiệm của cơ quan, tổ chức, cá nhân.",
            "3. Là trách nhiệm của cảnh sát giao thông",
            "4. Là trắc nhiệm người tham gia giao thông",
            2
        )
        questionList.add(ques6)

        val ques7 = Question(
            7,
            "Người ngồi trên xe mô tô hai bánh, ba bánh, xe gắn máy khi tham gia giao thông có được mang, vác vật cồng kềnh hay không ?",
            "1. Được mang, vác tuỳ trường hợp cụ thể",
            "2. Không được mang, vác",
            "3. Được mang, vác nhưng phải đảm bảo an toàn.",
            "4. Tuỳ ý người tham gia giao thông",
            1
        )
        questionList.add(ques7)

        val ques8 = Question(
            8,
            "Cuộc đua xe chỉ được thực hiện khi nào ?",
            "1. Diễn ra trên đường phố không có người qua lại.",
            "2. Được người dân ủng hộ.",
            "3. Được cơ quan có thẩm quyền cấp phép.",
            "4. Tuỳ ý người tham gia cuộc đua",
            3
        )
        questionList.add(ques8)

        val ques9 = Question(
            9,
            "Phần của đường bộ được sử dụng cho các phương tiện giao thông qua lại là gì?",
            "1. Phần mặt đường và lề đường.",
            "2. Phần đường xe chạy.",
            "3. Phần đường xe cơ giới.",
            "4. Không đáp án nào đúng",
            2
        )
        questionList.add(ques9)


        val ques10 = Question(
            10,
            "Để báo hiệu cho xe phía trước biết xe mô tô của bạn muốn vượt, bạn phải có tín hiệu như thế nào dưới đây?",
            "1. Ra tín hiệu bằng tay rồi cho xe vượt qua.",
            "2. Tăng ga mạnh để gây sự chú ý rồi cho xe vượt qua.",
            "3. Bạn phải có tín hiệu bằng đèn hoặc còi.",
            "4. Bạn có thể tự động vượt",
            3
        )
        questionList.add(ques10)
        return questionList
    }
}
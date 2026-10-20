package com.example.demo.modle;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.annotation.Id;
import java.util.HashSet;
import java.util.Set;

@Document(collation = "chats")
@Data
@NoArgsConstructor
public class Chat {
    @Id
    private String Id;
    private Set <String> UsersId = new HashSet<>();
    private ChatType type;
    private enum ChatType{
        PRIVATE,GROUP,CHANEL
    }
    private String PhotoUrl;
}

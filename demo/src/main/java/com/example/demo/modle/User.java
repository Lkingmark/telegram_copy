package com.example.demo.modle;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.annotation.Id;
import java.time.LocalDate;

@Document(collation = "users")
@Data
@NoArgsConstructor
public class User {
    @Id
    private String Id;
    private String Name;
    @Indexed(unique = true)
    private String UserName;
    private LocalDate DateOfBirth;
    @Indexed(unique = true)
    private Number PhoneNumber;
    private String Bio;
    private String PhotoUrl;
}

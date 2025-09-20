# 📚 Hướng dẫn sử dụng Migrations

## 🎯 Migrations là gì?

Migrations là hệ thống quản lý thay đổi database schema. Nó giúp bạn:
- ✅ Theo dõi mọi thay đổi database
- ✅ Đồng bộ database giữa các môi trường (dev, staging, production)
- ✅ Rollback khi có lỗi
- ✅ Làm việc nhóm hiệu quả

## 📁 Cấu trúc thư mục migrations/

```
migrations/
├── env.py              # Cấu hình môi trường Alembic
├── script.py.mako      # Template cho file migration
└── versions/           # Chứa các file migration
    ├── 001_initial_tables.py
    ├── 002_add_duration_field.py
    └── ...
```

## 🔧 Các lệnh cơ bản

### 1. Tạo migration mới
```bash
# Tự động tạo migration từ thay đổi model
alembic revision --autogenerate -m "Mô tả thay đổi"

# Tạo migration trống để viết tay
alembic revision -m "Mô tả thay đổi"
```

### 2. Chạy migration
```bash
# Chạy tất cả migration chưa chạy
alembic upgrade head

# Chạy migration đến phiên bản cụ thể
alembic upgrade <revision_id>

# Chạy migration tiếp theo
alembic upgrade +1
```

### 3. Rollback migration
```bash
# Quay lại migration trước
alembic downgrade -1

# Quay lại phiên bản cụ thể
alembic downgrade <revision_id>

# Quay lại tất cả
alembic downgrade base
```

### 4. Xem trạng thái
```bash
# Xem lịch sử migration
alembic history

# Xem migration hiện tại
alembic current

# Xem migration sẽ chạy
alembic show head
```

## 🔄 Quy trình làm việc

### Bước 1: Thay đổi Model
```python
# app/models/song.py
class Song(Base):
    __tablename__ = "songs"
    
    id = Column(String, primary_key=True)
    name = Column(String, nullable=False)
    artist = Column(String, nullable=False)
    # Thêm field mới
    duration = Column(Integer, nullable=True)  # ← Thay đổi này
```

### Bước 2: Tạo Migration
```bash
alembic revision --autogenerate -m "Add duration field to songs"
```

### Bước 3: Kiểm tra Migration
File migration được tạo trong `migrations/versions/`:
```python
def upgrade() -> None:
    # Thêm cột duration
    op.add_column('songs', sa.Column('duration', sa.Integer(), nullable=True))

def downgrade() -> None:
    # Xóa cột duration
    op.drop_column('songs', 'duration')
```

### Bước 4: Chạy Migration
```bash
alembic upgrade head
```

## 🚀 Ví dụ thực tế

### Tạo bảng ban đầu
```bash
# 1. Tạo migration cho bảng users và songs
alembic revision --autogenerate -m "Create users and songs tables"

# 2. Chạy migration
alembic upgrade head
```

### Thêm cột mới
```bash
# 1. Sửa model (thêm field mới)
# 2. Tạo migration
alembic revision --autogenerate -m "Add duration to songs"

# 3. Chạy migration
alembic upgrade head
```

### Xóa cột
```bash
# 1. Sửa model (xóa field)
# 2. Tạo migration
alembic revision --autogenerate -m "Remove duration from songs"

# 3. Chạy migration
alembic upgrade head
```

## ⚠️ Lưu ý quan trọng

1. **Luôn backup database** trước khi chạy migration
2. **Kiểm tra migration** trước khi chạy
3. **Test migration** trên môi trường dev trước
4. **Không sửa file migration** đã chạy
5. **Commit migration files** vào git

## 🆘 Xử lý lỗi

### Lỗi: "relation already exists"
```bash
# Xóa migration và tạo lại
rm migrations/versions/latest_migration.py
alembic revision --autogenerate -m "Fix migration"
```

### Lỗi: "can't locate revision"
```bash
# Reset migration history
alembic stamp head
alembic revision --autogenerate -m "Recreate migrations"
```

### Rollback khi có lỗi
```bash
# Quay lại migration trước
alembic downgrade -1

# Hoặc quay lại migration cụ thể
alembic downgrade <revision_id>
```

## 📝 Best Practices

1. **Tên migration rõ ràng**: "Add user email verification"
2. **Migration nhỏ**: Mỗi migration chỉ làm 1 việc
3. **Test migration**: Chạy test sau mỗi migration
4. **Backup thường xuyên**: Trước khi chạy migration quan trọng
5. **Review migration**: Kiểm tra code migration trước khi chạy

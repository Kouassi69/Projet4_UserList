import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        let dim: CGFloat = 200
        VStack {
            AsyncImage(url: URL(string: user.picture.large)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: dim, height: dim)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
                    .frame(width: dim, height: dim)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading) {
                Text("\(user.name.first) \(user.name.last)")
                    .font(.headline)
                Text("\(user.dob.date)")
                    .font(.subheadline)
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("\(user.name.first) \(user.name.last)")
    }
}
/*
struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: UserViewModel(repository: UserListRepository()))
    }
}*/
/*
#Preview {
    UserDetailView(user: User)
}*/
